import 'package:bloc/bloc.dart';
import 'package:shopping_app/core/constants/functions.dart';
import 'package:shopping_app/data/model/cart/cart_data_model.dart';
import 'package:shopping_app/data/repository/repository.dart';
import 'package:shopping_app/data/web_services/web_services.dart';
import 'package:shopping_app/presentation/business_logic/cubit/cart/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  Repository repository = Repository(WebServices());

  CartCubit() : super(CartLoading());

  void getCart() async {
    try {
      emit(CartLoading());

      final carts = await repository.getCartRepository();

      final userCart = carts.firstWhere(
        (c) => c.id == UserSession.shoppingCartId,
        orElse: () => throw Exception("السلة غير موجودة للمستخدم"),
      );

      if (userCart.shoppingCartItems.isNotEmpty) {
        emit(CartLoaded(userCart));
      } else {
        emit(EmptyCart());
      }
    } catch (e, stackTrace) {
      print("❌ خطأ أثناء تحميل السلة: $e");
      print(stackTrace);
      emit(CartError("حدث خطأ غير متوقع."));
    }
  }

  void deleteProductFromCart(String productId) async {
    final currentState = state;
    if (currentState is CartLoaded) {
      try {
        await repository.deleteProductFromCartRepository(productId);

        // إنشاء نسخة محدثة من عناصر السلة بعد حذف المنتج
        final updatedItems = currentState.cart.shoppingCartItems
            .where((item) => item.id != productId)
            .toList();

        final updatedCart = CartDataModel(
          id: currentState.cart.id,
          creationDate: currentState.cart.creationDate,
          customerId: currentState.cart.customerId,
          shoppingCartItems: updatedItems,
        );

        emit(ProductDeleted()); // لعرض رسالة النجاح

        if (updatedItems.isEmpty) {
          emit(EmptyCart()); // سلة فارغة، لا حاجة لبث CartLoaded
          return; // ✅ نخرج من الدالة حتى لا نبث CartLoaded بعدها
        }

        emit(CartLoaded(updatedCart)); // تحديث السلة فقط إذا بقيت فيها منتجات
      } catch (e) {
        print("❌ خطأ أثناء حذف المنتج: $e");
        emit(CartError("فشل في حذف المنتج"));
      }
    }
  }

  bool isProductInCartByProductId(String productId) {
    if (state is CartLoaded) {
      final cartState = state as CartLoaded;
      return cartState.cart.shoppingCartItems
          .any((item) => item.productId == productId);
    }
    return false;
  }

  void clearCart(String userId) async {
    try {
      emit(CartLoading());

      final response = await repository.clearCartRepository(userId);

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['succeeded'] == true) {
        // إعادة تحميل السلة من السيرفر بعد التفريغ
        final carts = await repository.getCartRepository();

        final cart = carts.firstWhere(
          (c) => c.id == UserSession.shoppingCartId,
          orElse: () => throw Exception("السلة غير موجودة للمستخدم"),
        );

        if (cart.shoppingCartItems.isNotEmpty) {
          emit(CartLoaded(cart));
        } else {
          emit(EmptyCart());
        }
      } else {
        emit(CartError("فشل في تفريغ السلة"));
      }
    } catch (e) {
      emit(CartError("حدث خطأ أثناء تفريغ السلة"));
      print("❌ clearCart error: $e");
    }
  }
}

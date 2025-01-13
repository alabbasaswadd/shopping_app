import 'package:shopping_app/data/model/products_model.dart';
import 'package:shopping_app/data/web_services/products_web_services.dart';

class ProductsRepository {
  final ProductsWebServices productsWebServices;
  ProductsRepository(this.productsWebServices);
  Future<List<ProductsModel>> getData() async {
    final products = await productsWebServices.getData();
    return products.map((product) => ProductsModel.fromJson(product)).toList();
  }
}



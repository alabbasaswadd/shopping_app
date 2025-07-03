// lib/logic/cubit/user/user_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/constants/functions.dart';
import 'package:shopping_app/data/model/user/user_model.dart';
import 'package:shopping_app/data/repository/products_repository.dart';
import 'package:shopping_app/data/web_services/web_services.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final Repository repository = Repository(WebServices());

  UserCubit() : super(UserInitial());

  Future<void> getUser(String userId) async {
    emit(UserLoading());
    try {
      final user = await repository.getUserRepository(userId);
      await UserSession.updateUser(user);
      emit(UserLoaded(user));
    } catch (e) {
      emit(UserError("حدث خطأ أثناء جلب بيانات المستخدم: ${e.toString()}"));
    }
  }

  Future<void> updateUser(String userId, UserModel user) async {
    emit(UserLoading());
    try {
      await repository.updateUserRepository(userId, user);
      await UserSession.updateUser(user);
      emit(UserUpdated());
    } catch (e) {
      emit(UserError("حدث خطأ أثناء تعديل بيانات المستخدم: ${e.toString()}"));
    }
  }

  Future<void> deleteUser(String userId) async {
    emit(UserLoading());
    try {
      await repository.deleteUserRepository(userId);
      await UserSession.clear();
      emit(UserDeleted());
    } catch (e) {
      emit(UserError("حدث خطأ أثناء حذف المستخدم: ${e.toString()}"));
    }
  }
}

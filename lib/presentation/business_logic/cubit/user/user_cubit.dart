// lib/logic/cubit/user/user_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/constants/functions.dart';
import 'package:shopping_app/data/model/user/user_data_model.dart';
import 'package:shopping_app/data/repository/repository.dart';
import 'package:shopping_app/data/web_services/web_services.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final Repository repository = Repository(WebServices());

  UserCubit() : super(UserInitial());

  Future<void> getUser(String userId) async {
    emit(UserLoading());
    try {
      final response = await repository.getUserRepository(userId);
      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['succeeded'] == true) {
        final user = response.data['data'];
        final userData = UserDataModel.fromJson(user);
        await UserSession.updateUser(userData);
        emit(UserLoaded(userData));
      }
    } catch (e) {
      emit(UserError("حدث خطأ أثناء جلب بيانات المستخدم: ${e.toString()}"));
    }
  }

  Future<void> updateUser(String userId, UserDataModel user) async {
    emit(UserLoading());
    final response = await repository.updateUserRepository(userId, user);
    try {
      print(response);
      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['succeeded'] == true) {
        final userData = response.data['data'];
        await UserSession.updateUser(UserDataModel.fromJson(userData));
        emit(UserUpdated());
      }
    } catch (e) {
      print(response);
      emit(UserError("حدث خطأ أثناء تعديل بيانات المستخدم: ${e.toString()}"));
    }
  }

  Future<void> deleteUser(String userId) async {
    emit(UserLoading());
    try {
      final response = await repository.deleteUserRepository(userId);
      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['succeeded'] == true) {
        await UserSession.clear();
        emit(UserDeleted());
      }
    } catch (e) {
      emit(UserError("حدث خطأ أثناء حذف المستخدم: ${e.toString()}"));
    }
  }
}

import 'package:hive/hive.dart';
import 'package:shopping_app/data/model/user_model.dart';

class AuthRepository {
  final Box userBox = Hive.box('userBox');

  Future<UserModel> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 1)); // محاكاة طلب API
    if (email == 'test@test.com' && password == '123456') {
      final user = UserModel(email: email, name: 'Test User');
      await userBox.put('user', user.toJson());
      return user;
    } else {
      throw Exception('البريد أو كلمة المرور غير صحيحة');
    }
  }

  Future<UserModel> signup(String email, String password, String name) async {
    await Future.delayed(Duration(seconds: 1));
    final user = UserModel(email: email, name: name);
    await userBox.put('user', user.toJson());
    return user;
  }

  UserModel? getSavedUser() {
    final data = userBox.get('user');
    if (data != null) {
      return UserModel.fromJson(Map<String, dynamic>.from(data));
    }
    return null;
  }

  void logout() {
    userBox.delete('user');
  }
}

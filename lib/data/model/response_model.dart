import 'package:shopping_app/data/model/auth_data_model.dart';

class AuthResponse {
  final bool succeeded;
  final AuthData? data;
  final Map<String, dynamic> errors;
  final String? message; // ✅ اجعلها nullable

  AuthResponse({
    required this.succeeded,
    this.data,
    required this.errors,
    this.message,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      succeeded: json['succeeded'] == true,
      data: json['data'] != null ? AuthData.fromJson(json['data']) : null,
      errors: json['errors'] is Map<String, dynamic> ? json['errors'] : {},
      message: json['message']?.toString(), // ✅ هنا مربط الفرس
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'succeeded': succeeded,
      'data': data?.toJson(),
      'errors': errors,
      'message': message,
    };
  }
}

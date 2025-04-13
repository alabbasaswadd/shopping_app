class UserModel {
  final String? id;
  final String name;
  final String email;
  final String? phone;
  final String? token; // في حال استخدمت توكن من API

  UserModel({
     this.id,
    required this.name,
    required this.email,
    this.phone,
    this.token,
  });

  // التحويل من JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      token: json['token'],
    );
  }

  // التحويل إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'token': token,
    };
  }
}

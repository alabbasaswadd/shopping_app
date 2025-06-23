class AuthData {
  final String? id;
  final String? token;
  final String? userName;
  final String? customerId;

  AuthData({
    this.id,
    this.token,
    this.userName,
    this.customerId,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      id: json['id'] ?? "",
      token: json['token'] ?? "",
      userName: json['userName'] ?? "",
      customerId: json['customerId'] ?? "",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
      'userName': userName,
      'customerId': customerId,
    };
  }
}

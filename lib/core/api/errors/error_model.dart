class ErrorModel {
  final String message;
  final Map<String, List<String>> errors;

  ErrorModel({
    required this.message,
    required this.errors,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      message: json['message'],
      errors: Map<String, List<String>>.from(
        json['errors'].map(
          (key, value) => MapEntry(key, List<String>.from(value)),
        ),
      ),
    );
  }
}

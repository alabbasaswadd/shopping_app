class ProductsModel {
  final String name;
  final double price;
  final String image;
  final String categoryId;
  final String currency;
  final String shopeId;
  final String description;

  ProductsModel({
    required this.name,
    required this.price,
    required this.image,
    required this.categoryId,
    required this.currency,
    required this.shopeId,
    required this.description,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      name: json['name'],
      price: json['price'].toDouble(),
      image: json['image'],
      categoryId: json['categoryId'],
      currency: json['currency'],
      shopeId: json['shopeId'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'image': image,
        'categoryId': categoryId,
        'currency': currency,
        'shopeId': shopeId,
        'description': description,
      };
}

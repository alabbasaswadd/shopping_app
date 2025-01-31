class ProductsModel {
  final String title;
  final String? description;
  final String image;
  final double price;
  int quantity;

  ProductsModel(
      {required this.title,
      this.description,
      required this.image,
      required this.price,
      this.quantity = 1});

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      title: json['title'],
      description: json['description'],
      image: json['image'],
      price: json['price'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'image': image,
      'price': price,
    };
  }
}

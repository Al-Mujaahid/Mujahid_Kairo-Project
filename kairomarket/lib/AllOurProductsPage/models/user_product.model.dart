class UserProducts {
  String image;
  String product_name;
  String description;
  String category;
  String price;
  int id;
  int user_id;

  UserProducts({
    this.image,
    this.product_name,
    this.category,
    this.description,
    this.price,
    this.id,
    this.user_id,
  });

  factory UserProducts.fromMap(Map<String, dynamic> json, [param1]) {
    return UserProducts(
      image: json['image'] ?? '',
      product_name: json['product_name'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? '',
      category: json['category'] ?? '',
      id: json['id'] ?? 0,
      user_id: json['user_id'] ?? 0,
    );
  }
}

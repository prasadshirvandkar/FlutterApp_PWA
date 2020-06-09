class Product {
  String productId;
  String name;
  String description;
  String price;
  String category;
  String averageMakingTime;
  String weight;
  String quantity;
  List<String> images;
  String dateTime;
  bool inStock;

  Product(
      {this.productId,
        this.name,
        this.description,
        this.price,
        this.category,
        this.averageMakingTime,
        this.weight,
        this.quantity,
        this.images,
        this.inStock});

  Product.fromMap(Map snapshot, String productId)
      : productId = productId ?? '23g34gw234gq3g4gw4',
        price = snapshot['price'] ?? '',
        name = snapshot['name'] ?? '',
        description = snapshot['description'] ?? '',
        category = snapshot['category'] ?? '',
        averageMakingTime = snapshot['averageMakingTime'] ?? '',
        weight = snapshot['weight'] ?? '',
        quantity = snapshot['quantity'] ?? '',
        images = List<String>.from(snapshot['images'] ?? <String>[]),
        inStock = snapshot['instock'] ?? false;

  toJson() {
    return {
      'price': price,
      'name': name,
      'description': description,
      'category': category,
      'averageMakingTime': averageMakingTime,
      'weight': weight,
      'quantity': quantity,
      'images': images,
      'instock': inStock
    };
  }
}

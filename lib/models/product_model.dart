class Product {
  final String id;
  final String name;
  final double price;
  final String shopId;
  final String shopName;
  final double distance;
  final String category;
  final String? imageUrl;
  final DateTime updatedAt;
  final List<String> tags;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.shopId,
    required this.shopName,
    required this.distance,
    required this.category,
    this.imageUrl,
    required this.updatedAt,
    this.tags = const [],
  });
}


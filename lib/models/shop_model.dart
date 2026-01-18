class Shop {
  final String id;
  final String name;
  final String category;
  final double rating;
  final String address;
  final double distance;
  final bool isOpen;
  final List<String> tags;

  Shop({
    required this.id,
    required this.name,
    required this.category,
    required this.rating,
    required this.address,
    required this.distance,
    required this.isOpen,
    this.tags = const [],
  });
}
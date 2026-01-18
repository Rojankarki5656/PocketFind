class Contribution {
  final String id;
  final String type; // 'shop', 'product', 'price_update'
  final String name;
  final DateTime date;
  final int pointsEarned;

  Contribution({
    required this.id,
    required this.type,
    required this.name,
    required this.date,
    this.pointsEarned = 10,
  });
}
import 'contribution_model.dart';
class UserModel {
  final String id;
  final String name;
  final String? email;
  final String? phone;
  final int points;
  final String badge;
  final DateTime joinedDate;
  final List<Contribution> contributions;
  final List<String> savedProducts;

  UserModel({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.points = 0,
    this.badge = 'Explorer',
    required this.joinedDate,
    this.contributions = const [],
    this.savedProducts = const [],
  });
}

// Extension for copyWith method
extension UserModelCopyWith on UserModel {
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    int? points,
    String? badge,
    DateTime? joinedDate,
    List<Contribution>? contributions,
    List<String>? savedProducts,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      points: points ?? this.points,
      badge: badge ?? this.badge,
      joinedDate: joinedDate ?? this.joinedDate,
      contributions: contributions ?? this.contributions,
      savedProducts: savedProducts ?? this.savedProducts,
    );
  }
}
import 'package:flutter/foundation.dart';
import 'package:pocketfind/models/user_model.dart';
import 'package:pocketfind/models/contribution_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _user != null;

  Future<void> loadUser() async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock user data
    _user = UserModel(
      id: 'user_001',
      name: 'Rahul Sharma',
      email: 'rahul@example.com',
      phone: '+919876543210',
      points: 1250,
      badge: 'Contributor',
      joinedDate: DateTime.now().subtract(const Duration(days: 45)),
      contributions: [
        Contribution(
          id: 'cont_001',
          type: 'shop',
          name: 'Ramesh Snacks',
          date: DateTime.now().subtract(const Duration(days: 30)),
          pointsEarned: 50,
        ),
        Contribution(
          id: 'cont_002',
          type: 'product',
          name: 'Jhampat',
          date: DateTime.now().subtract(const Duration(days: 25)),
        ),
        Contribution(
          id: 'cont_003',
          type: 'price_update',
          name: 'Updated Momos price',
          date: DateTime.now().subtract(const Duration(days: 10)),
        ),
      ],
      savedProducts: ['prod_001', 'prod_002', 'prod_003'],
    );

    _isLoading = false;
    notifyListeners();
  }

  void addPoints(int points) {
    if (_user != null) {
      _user = _user!.copyWith(
        points: _user!.points + points,
      );
      
      // Update badge based on points
      if (_user!.points >= 1000) {
        _user = _user!.copyWith(badge: 'Contributor');
      } else if (_user!.points >= 500) {
        _user = _user!.copyWith(badge: 'Explorer');
      }
      
      notifyListeners();
    }
  }

  void addContribution(Contribution contribution) {
    if (_user != null) {
      _user = _user!.copyWith(
        contributions: [contribution, ..._user!.contributions],
      );
      addPoints(contribution.pointsEarned);
      notifyListeners();
    }
  }

  void toggleSaveProduct(String productId) {
    if (_user != null) {
      final saved = _user!.savedProducts;
      if (saved.contains(productId)) {
        _user = _user!.copyWith(
          savedProducts: saved.where((id) => id != productId).toList(),
        );
      } else {
        _user = _user!.copyWith(
          savedProducts: [...saved, productId],
        );
      }
      notifyListeners();
    }
  }
}
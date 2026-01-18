import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider extends ChangeNotifier {
  String _currentLocation = 'Kormangala, Bangalore';
  Position? _currentPosition;
  bool _isLoading = false;
  bool _locationEnabled = false;

  String get currentLocation => _currentLocation;
  Position? get currentPosition => _currentPosition;
  bool get isLoading => _isLoading;
  bool get locationEnabled => _locationEnabled;

  Future<void> requestLocationPermission() async {
    try {
      _isLoading = true;
      notifyListeners();

      final permission = await Geolocator.checkPermission();
      
      if (permission == LocationPermission.denied) {
        final newPermission = await Geolocator.requestPermission();
        if (newPermission == LocationPermission.denied ||
            newPermission == LocationPermission.deniedForever) {
          _locationEnabled = false;
          return;
        }
      }

      _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      _locationEnabled = true;
      
      // You can implement reverse geocoding here to get address from coordinates
      // For now, using a mock location
      _currentLocation = await _getAddressFromCoordinates(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );
      
    } catch (e) {
      _locationEnabled = false;
      _currentLocation = 'Location unavailable';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String> _getAddressFromCoordinates(double lat, double lng) async {
    // Mock implementation - in real app, use geocoding API
    return 'Kormangala, Bangalore';
  }

  void updateLocation(String location) {
    _currentLocation = location;
    notifyListeners();
  }

  Future<void> setManualLocation(String location) async {
    _currentLocation = location;
    _locationEnabled = false;
    notifyListeners();
  }

  double calculateDistance(double lat, double lng) {
    if (_currentPosition == null) return 0.0;
    
    return Geolocator.distanceBetween(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
      lat,
      lng,
    );
  }
}
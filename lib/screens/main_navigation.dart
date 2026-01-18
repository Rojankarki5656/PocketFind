import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pocketfind/services/location_provider.dart';
import 'home/home_screen.dart';
import 'search/search_screen.dart';
import 'contribute/contribute_screen.dart';
import 'profile/profile_screen.dart';
import 'package:pocketfind/core/theme/app_theme.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  bool _locationDialogShown = false;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const SizedBox(), // 👈 placeholder for Map
    const ContributeScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLocationPermission();
    });
  }

  Future<void> _checkLocationPermission() async {
    final locationProvider = Provider.of<LocationProvider>(
      context,
      listen: false,
    );

    if (!locationProvider.locationEnabled && !_locationDialogShown) {
      _locationDialogShown = true;
      await _showLocationDialog();
    }
  }

  Future<void> _showLocationDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Enable Location'),
        content: const Text(
          'Enable location to see nearby shops and prices around you.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Provider.of<LocationProvider>(
                context,
                listen: false,
              ).setManualLocation('Set Location Manually');
            },
            child: const Text('Set Manually'),
          ),
          ElevatedButton(
            onPressed: () async {
              await Provider.of<LocationProvider>(
                context,
                listen: false,
              ).requestLocationPermission();
              Navigator.pop(context);
            },
            child: const Text('Allow Location'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 6,
        backgroundColor: AppTheme.primaryColor,
        onPressed: () {},
        child: const Icon(Icons.location_on, color: Colors.white),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            if (index == 2) return; // prevent tap on empty slot
            setState(() => _selectedIndex = index);
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppTheme.primaryColor,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              activeIcon: Icon(Icons.search),
              label: 'Search',
            ),

            // 👇 CENTER EMPTY ITEM
            BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),

            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              activeIcon: Icon(Icons.add_circle),
              label: 'Contribute',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

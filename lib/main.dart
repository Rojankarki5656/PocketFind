import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pocketfind/core/theme/app_theme.dart';
import 'package:pocketfind/screens/onboarding/onboarding_screen.dart';
import 'package:pocketfind/providers/location_provider.dart';
import 'package:pocketfind/providers/user_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()..loadUser()),
      ],
      child: MaterialApp(
        title: 'Pocket Find',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const OnboardingScreen(),
      ),
    );
  }
}
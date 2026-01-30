import 'package:flutter/material.dart';
import 'package:vaikuttaja_app/screens/splash_screen.dart';
import 'package:vaikuttaja_app/theme/app_theme_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vaikuttaja App',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}

// Sovelluksen käynnistyspiste
// Tässä määritellään pääasiallinen teema ja aloitusnäyttö
// Käytetään MaterialAppia, joka on Flutterin tarjoama widget
// sovelluksen perusrakenteen luomiseen
// AppTheme.lightTheme määrittelee sovelluksen ulkoasun 

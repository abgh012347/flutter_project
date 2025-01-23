import 'package:flutter/material.dart';
import './start.dart';
import './best_recommand.dart';
import './location_recommand.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Cherry',
        popupMenuTheme: PopupMenuThemeData(
          color: Colors.grey[800], // Set menu item background color
        ),
      ),
      routes: {
        '/': (context) => const StartPage(),
        '/best_recommand': (context) => const BestRecommandPage(),
        '/location_recommand': (context) => const LocationRecommandPage(),
      },
    );
  }
}
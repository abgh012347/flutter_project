import 'package:flutter/material.dart';
import './start.dart';
import './best_recommand.dart';
import './location_recommand.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _selectedLanguage; // Store selected language

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Cherry',
        popupMenuTheme: PopupMenuThemeData(
          color: Colors.grey[800],
        ),

      ),
      home: StartPage(
        onLanguageSelected: (language) { // Callback to update selected language
          setState(() {
            _selectedLanguage = language;
          });
          // Navigate to the next page after language selection
          Navigator.pushNamed(
            context,
            '/best_recommand',
            arguments: language, // Pass the selected language as an argument
          );
        },
      ),
      routes: {
        '/best_recommand': (context) => BestRecommandPage(
          selectedLanguage: ModalRoute.of(context)!.settings.arguments
          as String, // Access the selected language from arguments
        ),
        '/location_recommand': (context) => const LocationRecommandPage(),
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_project/best_recommand.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String selectedLanguage = "한국어";

  // Map to store language codes and their native names and guide texts
  final Map<String, Map<String, String>> languageData = {
    "한국어": {
      "name": "한국어",
      "guide": "Seoulution",
      "tapAnywhere": "아무 곳이나 눌러주세요",
    },
    "영어": {
      "name": "English",
      "guide": "Seoulution",
      "tapAnywhere": "Tap anywhere",
    },
    "일본어": {
      "name": "日本語",
      "guide": "ソウルルーション",
      "tapAnywhere": "どこでもタップしてください",
    },
    "중국어": {
      "name": "中國語",
      "guide": "首尔路昇",
      "tapAnywhere": "点击任意位置",
    },
  };

  void goToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BestRecommandPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: goToNextPage,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              "images/seoul.png",
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 40,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(50),
                ),
                padding:
                const EdgeInsets.symmetric(horizontal: 9, vertical: 19),
                child: DropdownButton<String>(
                  value: selectedLanguage,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors
                      .white38),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.bold),
                  underline: Container(
                    height: 2,
                    color: Colors.transparent,
                  ),
                  dropdownColor: Colors.black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedLanguage = newValue!;
                    });
                  },
                  items: languageData.keys
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(languageData[value]!['name']!),
                    );
                  }).toList(),
                ),
              ),
            ),
            Positioned(
              top: 65,
              left: 30,
              child: Text(
                languageData[selectedLanguage]!['guide']!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cherry',
                ),
              ),
            ),
            Positioned( // Position "Tap anywhere" message higher with background
              bottom: 100, // Moved higher
              left: 0,
              right: 0,
              child: Center(
                child: Container( // Added Container for background
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5), // Transparent black background
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10), // Added padding
                  child: Text(
                    languageData[selectedLanguage]!['tapAnywhere']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
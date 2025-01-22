import 'package:flutter/material.dart';
import 'package:flutter_project/language_provider.dart';
import 'best_recommand.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String _selectedLanguage = "한국어";
  final LanguageProvider _languageProvider = LanguageProvider();

  @override
  void initState() {
    super.initState();
    _fetchLanguage();
  }

  void _saveLanguage(String language) async {
    try {
      await _languageProvider.saveLanguage(language);
      setState(() {
        _selectedLanguage = language;
      });
    } catch (e) {
      debugPrint("Failed to save language: ${e}");
    }
  }

  void _fetchLanguage() async {
    try {
      String language = await _languageProvider.fetchCurrentLanguage();
      setState(() {
        _selectedLanguage = language;
      });
    } catch (e) {
      debugPrint("Failed to fetch language: $e");
    }
  }


  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white.withAlpha(230),
          title: const Text("언어 설정"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  _saveLanguage("한국어");
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withAlpha(230),
                  shadowColor: Colors.black.withAlpha(230),
                  elevation: 5,
                  minimumSize: const Size(180, 60),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text("한국어"),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  _saveLanguage("영어");
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withAlpha(230),
                  shadowColor: Colors.black.withAlpha(230),
                  elevation: 5,
                  minimumSize: const Size(180, 60),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text("영어"),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  _saveLanguage("일본어"); // API 호출
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withAlpha(230),
                  shadowColor: Colors.black.withAlpha(230),
                  elevation: 5,
                  minimumSize: const Size(180, 60),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text("일본어"),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  _saveLanguage("중국어"); // API 호출
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withAlpha(230),
                  shadowColor: Colors.black.withAlpha(230),
                  elevation: 5,
                  minimumSize: const Size(180, 60),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text("중국어"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("닫기",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _goToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BestRecommandPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _goToNextPage,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/seoul.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: ElevatedButton(
                onPressed: _showLanguageDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.7),
                  foregroundColor: Colors.black,
                ),
                child: const Text("Language"),
              ),
            ),
            Positioned(
              bottom: 200,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Text(
                    "환영합니다!",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "화면을 터치해주세요",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

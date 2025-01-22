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
  double _imageLeft = -350; // 초기 위치
  bool _isAnimationCompleted = false;
  bool _isContentVisible = false;

  @override
  void initState() {
    super.initState();
    _fetchLanguage();
    _startImageAnimation();
  }

  void _startImageAnimation() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _imageLeft = -220;
      });

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _isAnimationCompleted = true;
        });
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            _isContentVisible = true;
          });
        });
      });
    });
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
      debugPrint("Failed to fetch language: ${e}");
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
              _languageButton("한국어"),
              const SizedBox(height: 15),
              _languageButton("ENG"),
              const SizedBox(height: 15),
              _languageButton("日本語"),
              const SizedBox(height: 15),
              _languageButton("中國語"),
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
                  )
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _languageButton(String language) {
    return ElevatedButton(
      onPressed: () {
        _saveLanguage(language);
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withAlpha(230),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(255), // 모서리 둥글게
          side: const BorderSide(color: Colors.white, width: 2), // 테두리 추가
        ),
        minimumSize: const Size(180, 60),
        padding: const EdgeInsets.symmetric(vertical: 15),
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: Text(language),
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
            AnimatedPositioned(
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              left: _imageLeft,
              top: 0,
              child: Image.asset(
                "images/seoul.png",
              ),
            ),
            if (_isAnimationCompleted)
              AnimatedOpacity(
                opacity: _isAnimationCompleted ? 1 : 0,
                duration: const Duration(milliseconds: 800),
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeInOut,
                      top: _isContentVisible ? 40 : -50, // 버튼이 위에서 아래로 등장
                      right: 20,
                      child: ElevatedButton(
                        onPressed: _showLanguageDialog,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black.withAlpha(30),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("LANG"),
                      ),
                    ),
                    Positioned(
                      bottom: 200,
                      left: 0,
                      right: 0,
                      child: AnimatedOpacity(
                        opacity: _isContentVisible ? 1 : 0,
                        duration: const Duration(milliseconds: 800),
                        child: Column(
                          children: [
                            Text(
                              "환영합니다!",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 45,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "화면을 터치해주세요",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
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

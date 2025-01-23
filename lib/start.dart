import 'package:flutter/material.dart';
import 'package:flutter_project/language_provider.dart';
import 'best_recommand.dart';

class StartPage extends StatefulWidget {
  final ValueChanged<String> onLanguageSelected;

  const StartPage({super.key, required this.onLanguageSelected});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String _selectedLanguage = "한국어";
  final LanguageProvider _languageProvider = LanguageProvider();
  double _imageLeft = -350; // 초기 위치
  bool _isAnimationCompleted = false;
  bool _isContentVisible = false;

  void _saveLanguage(String language) async {
    try {
      await _languageProvider.saveLanguage(language);
      setState(() {
        _selectedLanguage = language;
      });
      widget.onLanguageSelected(language); // Call the callback function
    } catch (e) {
      debugPrint("Failed to save language: ${e}");
    }
  }

  final Map<String, Map<String, String>> languageData = {
    "한국어": {
      "name": "한국어",
      "guide": "서울 탐방",
      "tapAnywhere": "아무 곳이나 눌러주세요",
      "welcome": "환영합니다!",
      "projectName": "Seoulution", // Project name in Korean pronunciation
    },
    "ENG": {
      "name": "ENG",
      "guide": "Explore Seoul",
      "tapAnywhere": "Tap anywhere",
      "welcome": "Welcome!",
      "projectName": "Seoulution", // Project name in English pronunciation
    },
    "日本語": {
      "name": "日本語",
      "guide": "ソウル探検",
      "tapAnywhere": "どこでもタップしてください",
      "welcome": "ようこそ",
      "projectName": "ソウルーション", // Project name in Japanese pronunciation
    },
    "中國語": {
      "name": "中國語",
      "guide": "探索首尔",
      "tapAnywhere": "点击任意位置",
      "welcome": "欢迎",
      "projectName": "首尔解决方案", // Project name in Chinese pronunciation
    },
  };

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await _fetchLanguage();
    _startImageAnimation();
  }

  Future<void> _fetchLanguage() async {
    try {
      String language = await _languageProvider.fetchCurrentLanguage();
      setState(() {
        _selectedLanguage = language;
      });
    } catch (e) {
      debugPrint("Failed to fetch language: ${e}");
    }
  }

  void _startImageAnimation() {
    Future.delayed(const Duration(milliseconds: 2000), () {
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

  void _goToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BestRecommandPage(
          selectedLanguage: _selectedLanguage, // Pass selected language as argument
        ),
      ),
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
                    Positioned(
                      bottom: 570,
                      left: 0,
                      right: 0,
                      child: AnimatedOpacity(
                        opacity: _isContentVisible ? 1 : 0,
                        duration: const Duration(milliseconds: 800),
                        child: Column(
                          children: [
                            Text(
                              languageData[_selectedLanguage]!['welcome']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              languageData[_selectedLanguage]!['projectName']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 60,
                      left: 60,
                      child: Text(
                        languageData[_selectedLanguage]!['guide']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeInOut,
                      top: _isContentVisible ? 55 : -50,
                      right: 20,
                      child: DropdownButtonHideUnderline(
                        child: _buildPopupMenuButton(),
                      ),
                    ),
                    Positioned(
                      bottom: 100, // Moved higher
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Text(
                            languageData[_selectedLanguage]!['tapAnywhere']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
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
          ],
        ),
      ),
    );
  }

  Widget _buildPopupMenuButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end, // 메뉴 버튼을 화면 오른쪽 끝에 위치
      children: <Widget>[
        Text(
          languageData[_selectedLanguage]!['name']!, // 현재 선택된 언어 표시
          style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold
          ),
        ),
        PopupMenuButton<String>(
          onSelected: (String value) {
            setState(() {
              _selectedLanguage = value;
            });
            _saveLanguage(value);
          },
          itemBuilder: (BuildContext context) => languageData.keys.map((String value) {
            return PopupMenuItem<String>(
              value: value,
              child: Text(languageData[value]!['name']!,
                style: TextStyle(
                    color: Colors.black45
                ),),
            );
          }).toList(),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
          offset: const Offset(8.5, 40), // 버튼 바로 아래에서 메뉴 시작
          color: Colors.transparent, // 메뉴 배경색
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // 메뉴의 모서리 둥글게
          elevation: 500, // 메뉴의 그림자 높이
        ),
      ],
    );
  }

}

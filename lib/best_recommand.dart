import 'package:flutter/material.dart';
import 'package:flutter_project/location_recommand.dart';

class BestRecommandPage extends StatefulWidget {
  final String selectedLanguage;

  const BestRecommandPage({super.key, required this.selectedLanguage});

  @override
  State<BestRecommandPage> createState() => _BestRecommandPageState();
}

class _BestRecommandPageState extends State<BestRecommandPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final Map<String, Map<String, String>> languageData = {
    "한국어": {
      "appBarTitle": "대표 추천 장소",
      "tapMessage": "화면을 누르시면\n더욱 상세하게 보여집니다.",
    },
    "ENG": {
      "appBarTitle": "Recommended Places",
      "tapMessage": "Tap the screen\nto see more details.",
    },
    "日本語": {
      "appBarTitle": "代表的なおすすめスポット",
      "tapMessage": "画面をタップすると\n詳細が表示されます。",
    },
    "中國語": {
      "appBarTitle": "代表推荐地点",
      "tapMessage": "点击屏幕\n查看更多详情。",
    },
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 2).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward().then((value) =>
            _navigateToLocationRecommandPage(context, widget.selectedLanguage));
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(languageData[widget.selectedLanguage]!['appBarTitle']!),
          backgroundColor: const Color.fromARGB(255, 34, 163, 255),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 8,
              child: Transform.scale(
                scale: _animation.value,
                child: Image.asset(
                  'images/seoul_hot_place.PNG',
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                alignment: Alignment.topCenter,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 26,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                          languageData[widget.selectedLanguage]!['tapMessage']!),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToLocationRecommandPage(BuildContext context,String languages) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationRecommandPage(selectedLanguage: languages),
      ),
    ).then((value) {
      _controller.reset();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.reset();
  }
}
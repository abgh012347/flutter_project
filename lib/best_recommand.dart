import 'package:flutter/material.dart';
import 'package:flutter_project/location_recommand.dart';

class BestRecommandPage extends StatefulWidget {
  const BestRecommandPage({super.key});

  @override
  State<BestRecommandPage> createState() => _BestRecommandPageState();
}

class _BestRecommandPageState extends State<BestRecommandPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

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
            _navigateToLocationRecommandPage(context));
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("대표 추천 장소",style: TextStyle(
              color: Color(0xFFF0F0F0)
          )),
          backgroundColor: const Color.fromARGB(255, 34, 163, 255),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 8,
              child: Transform.scale(
                scale: _animation.value, // 확대 애니메이션 적용
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
                  text: const TextSpan(
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 26,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: '화면을 누르시면\n'),
                      TextSpan(text: '더욱 상세하게 보여집니다.'),
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

  void _navigateToLocationRecommandPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LocationRecommandPage(),
      ),
    ).then((value) { // then 추가
      _controller.reset(); // 페이지에서 돌아올 때 애니메이션 초기화
    });
  }

  @override
  void didChangeDependencies() { // didChangeDependencies() 메서드 추가
    super.didChangeDependencies();
    _controller.reset(); // 애니메이션 컨트롤러 초기화
  }
}
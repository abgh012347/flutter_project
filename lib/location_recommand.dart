import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_project/location_info.dart';

class LocationRecommandPage extends StatefulWidget {
  const LocationRecommandPage({super.key});

  @override
  State<LocationRecommandPage> createState() => _LocationRecommandPageState();
}

class _LocationRecommandPageState extends State<LocationRecommandPage>
    with SingleTickerProviderStateMixin {
  int rating_time = 0;
  int secondsRemaining = 2;
  late Timer timer;
  double _width = 100.0;
  double _height = 100.0;


  late AnimationController _controller;
  late Animation<double> _animation;

  void _changeSize() {
    setState(() {
      // 크기를 변경 (예: 높이와 너비를 200으로 변경)
      _width = _width == 100.0 ? 300.0 : 100.0;
      _height = _height == 100.0 ? 500.0 : 100.0;
    });
  }


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    // _animation = Tween<double>(begin: 1.0, end: 1.5).animate(CurvedAnimation(
    //   parent: _controller,
    //   curve: Curves.easeInOut,
    // ));
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    startTimer();
  }

  //
  // _onTap(double x,double y) {
  //   setState(() {
  //     _width = _width == 0 ? _width = 300.0 : _width = 100.0;
  //     _height = _height == 0 ? _height = 300.0 : _height = 100.0;
  //   });
  //   }

  @override
  Widget build(BuildContext context) {
    // startTimer();
    // print(secondsRemaining);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "구별 추천 장소",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 34, 163, 255),
        centerTitle: true,
      ),
      body: Stack(
          children: [

        // Container(
        //       child : Image(image: AssetImage("images/seoul_detail.png"),
        //   fit: BoxFit.cover),
        //   color: Colors.red,
        //   ),


        // _buildCustomWidget(1, 120, 110, "강서구", 2, 170),
        // _buildCustomWidget(2, 70, 70, "양천구", 55, 245),
        // _buildCustomWidget(3, 88, 88, "구로구", 48, 285),
        // _buildCustomWidget(4, 77, 77, "금천구", 95, 335),
        // _buildCustomWidget(5, 95, 95, "영등포구", 100, 245),
        // _buildCustomWidget(6, 95, 95, "동작구", 136, 275),
        // _buildCustomWidget(7, 95, 95, "관악구", 142, 318),
        // _buildCustomWidget(8, 130, 140, "서초구", 212, 285),
        // _buildCustomWidget(9, 130, 130, "강남구", 244, 268),
        // _buildCustomWidget(10, 120, 120, "송파구", 296, 259),
        // _buildCustomWidget(11, 85, 85, "강동구", 353, 215),
        // _buildCustomWidget(12, 110, 110, "마포구", 95, 176),
        // _buildCustomWidget(13, 120, 120, "은평구", 107, 92),
        // _buildCustomWidget(14, 70, 70, "서대문구", 140, 170),
        // _buildCustomWidget(15, 100, 100, "종로구", 180, 130),
        // _buildCustomWidget(16, 70, 70, "중구", 198, 202),
        // _buildCustomWidget(17, 70, 70, "용산구", 185, 237),
        // _buildCustomWidget(18, 65, 65, "성동구", 250, 218),
        // _buildCustomWidget(19, 65, 65, "동대문구", 261, 176),
        // _buildCustomWidget(20, 110, 110, "성북구", 210, 120),
        // _buildCustomWidget(21, 100, 100, "강북구", 210, 70),
        // _buildCustomWidget(22, 100, 100, "도봉구", 227, 40),
        // _buildCustomWidget(23, 120, 120, "노원구", 270, 45),
        // _buildCustomWidget(24, 70, 70, "중랑구", 305, 155),
        // _buildCustomWidget(25, 70, 70, "광진구", 292, 218),

        _buildCustomWidget(1, 120, 110, "강서구", 2, 170),
        _buildCustomWidget(2, 70, 70, "양천구", 55, 245),
        _buildCustomWidget(3, 88, 88, "구로구", 48, 285),
        _buildCustomWidget(4, 77, 77, "금천구", 95, 335),
        _buildCustomWidget(5, 95, 95, "영등포구", 100, 245),
        _buildCustomWidget(6, 95, 95, "동작구", 136, 275),
        _buildCustomWidget(7, 95, 95, "관악구", 142, 318),
        _buildCustomWidget(8, 130, 140, "서초구", 212, 285),
        _buildCustomWidget(9, 130, 130, "강남구", 244, 268),
        _buildCustomWidget(10, 120, 120, "송파구", 296, 259),
        _buildCustomWidget(11, 85, 85, "강동구", 353, 215),
        _buildCustomWidget(12, 110, 110, "마포구", 95, 176),
        _buildCustomWidget(13, 120, 120, "은평구", 107, 92),
        _buildCustomWidget(14, 70, 70, "서대문구", 140, 170),
        _buildCustomWidget(15, 100, 100, "종로구", 180, 130),
        _buildCustomWidget(16, 70, 70, "중구", 198, 202),
        _buildCustomWidget(17, 70, 70, "용산구", 185, 237),
        _buildCustomWidget(18, 65, 65, "성동구", 250, 218),
        _buildCustomWidget(19, 65, 65, "동대문구", 261, 176),
        _buildCustomWidget(20, 110, 110, "성북구", 210, 120),
        _buildCustomWidget(21, 100, 100, "강북구", 210, 70),
        _buildCustomWidget(22, 100, 100, "도봉구", 227, 40),
        _buildCustomWidget(23, 120, 120, "노원구", 270, 45),
        _buildCustomWidget(24, 70, 70, "중랑구", 305, 155),
        _buildCustomWidget(25, 70, 70, "광진구", 292, 218),
        // _buildCustomWidget(26, 70, 70, "광진구", 0, 0),
        // _buildCustomWidget(26, 460, 440, "강", 0, -5),
        Column(children: [
          SizedBox(
            height: 575,
          ),
          Center(
            child: Text(
              "원하시는 지역을 \n클릭해 주십시요.",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ])
      ]),
    );

  }

  Widget _buildCustomWidget(int num, double width, double height,
      String location, double x, double y) {
    // rating_time++;
    return

         AnimatedContainer(
            width:  secondsRemaining == 0 ? width:100, //secondsRemaining == 0 ?
            height: secondsRemaining == 0 ? height:100,
            duration: Duration(seconds: 2),

            curve: Curves.bounceInOut,

            transform: secondsRemaining == 0
                ? Matrix4.translationValues(x, y, 0)
                : num < 12
                    ? Matrix4.translationValues(x, y + 800, 0)
                    : Matrix4.translationValues(x, -y - 200, 0),
            child: GestureDetector(
                behavior: HitTestBehavior.deferToChild,


              onTap: () {
                print("들어옴");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        SpaceaScreen(space_image: "images/${location}.png",select_value: location),
                  ),
                );
              }
                ,child: Image.asset("images/${location}.png")


            )
        );


  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        print(secondsRemaining);
        if (secondsRemaining == 0) {
          print("타이머 죽임");
          t.cancel();
        } else {
          secondsRemaining--;
          timer.isActive ? '타이머 실행중' : '타이머 죽음';
        }
      });
    });
  }
}





class SpaceaScreen extends StatefulWidget {
  const SpaceaScreen({Key? key, required this.space_image,required this.select_value}) : super(key: key);

  final String space_image;
  final String select_value;
  @override
  State<SpaceaScreen> createState() => _SpaceaScreenState();
  } // end of SpaceaScreen


class _SpaceaScreenState extends State<SpaceaScreen> {
  List<dynamic> items = [];
  bool isLoading = true;
  void initState(){
    fetchData();
  }
  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/api/locations/search?keyword=${widget.select_value}'));

    if (response.statusCode == 200) {
      setState(() {
        String responseBody = utf8.decode(response.bodyBytes);
        items = json.decode(responseBody);
        isLoading = false;
      });
    } else {
      throw Exception('데이터를 가져오는 데 실패했습니다.');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width*0.7;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Show space screen'),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child:Column(
          // child: Hero(
          //   tag: 'wowHero',
            children:[
              SizedBox(
                height: 30,
              ),
              Image.asset(
                widget.space_image,
                // fit: BoxFit.,
              ),
              SizedBox(
                height: 50,
              ),
              Expanded(
                child:Container(
                  height: 400,
                  child:
                  isLoading ? Center(child: CircularProgressIndicator())
                  :
                    ListView.builder(

                      itemCount: items.length,
                      itemBuilder: (context,index){
                        return GestureDetector(
                          onTap: () {
                            showPopup(context, items[index]["placeName"],items[index]["imgSrc"], items[index]["placeAddress"], items[index]["placeSubway"],items[index]["placeDescription"]);
                          },
                          child: Card(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(items[index]['imgSrc'].toString(),
                                      fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress)
                                      {
                                        if(loadingProgress == null){
                                          return child;
                                        }
                                        else {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                  .expectedTotalBytes != null
                                                  ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                                  (loadingProgress
                                                      .expectedTotalBytes ?? 1)
                                                  : null,
                                            ),
                                          ); //
                                        }
                                      },
                                        errorBuilder: (context, error, stackTrace) {
                                          return Center(child: Text('Error loading image')); // 오류 발생 시 메시지 표시
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(padding:  const EdgeInsets.only(left: 10.0),
                                 child: Column(

                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Text(items[index]['placeName'],
                                        style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                    ),),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        // width: width+,
                                        child: Padding(padding:  const EdgeInsets.only(left: 6.0),
                                          child: Text(items[index]['placeSubway'].toString()
                                            ,style: TextStyle(
                                            fontSize: 14,
                                            // color: Color(0XFFA5A5A5),
                                            color: Colors.grey[500],
                                          ),),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),

                              ],
                            ),

                          ),
                        // title: Text(items[index]['placeName']),
                        // subtitle: Text(items[index]['placeDescription']),
                        );

                      })
                )
              )
            ]

            ),
          ),
        ),
      );

  }
  void showPopup(context,title,image,address,subway,description){
    showDialog(
        context: context,
        builder: (context){
          return Dialog(
            child: Container(
              width: MediaQuery.of(context).size.width*0.8,
              height: 600,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),

                    child: Image.network(
                      image,
                      width: 200,
                      height: 200,),
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Text(title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),),
                  SizedBox(
                      height: 10
                  ),
                  Text(address,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.purple
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(subway,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.purple
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(description,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.purple
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                    label: Text("close"),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

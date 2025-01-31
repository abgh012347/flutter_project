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
import 'package:cached_network_image/cached_network_image.dart';

class LocationRecommandPage extends StatefulWidget {
  final String selectedLanguage;
  const LocationRecommandPage({super.key,required this.selectedLanguage});

  @override
  State<LocationRecommandPage> createState() => _LocationRecommandPageState();
}

class _LocationRecommandPageState extends State<LocationRecommandPage>
    with SingleTickerProviderStateMixin {
  int rating_time = 0;
  int secondsRemaining = 1;
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
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    // _animation = Tween<double>(begin: 1.0, end: 1.5).animate(CurvedAnimation(
    //   parent: _controller,
    //   curve: Curves.easeInOut,
    // ));
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    startTimer();
  }


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
            color: Colors.black,
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
            duration: Duration(milliseconds: 500),

            curve: Curves.fastEaseInToSlowEaseOut,
            transform: Matrix4.translationValues(x, y, 0),
            // transform: secondsRemaining == 0
            //     ? Matrix4.translationValues(x, y, 0)
            //     : num < 12
            //         ? Matrix4.translationValues(x, y + 800, 0)
            //         : Matrix4.translationValues(x, -y - 200, 0),
            child: GestureDetector(
                behavior: HitTestBehavior.deferToChild,


              onTap: () {
                print("들어옴");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        SpaceaScreen(space_image: "images/${location}.png",select_value: location,selectedLanguage: widget.selectedLanguage,),
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
  const SpaceaScreen({Key? key, required this.space_image,required this.select_value,required this.selectedLanguage}) : super(key: key);

  final String space_image;
  final String select_value;
  final String selectedLanguage;
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
    int selectedLanguageNum = 0;
    String keyword = widget.select_value;
    switch(widget.selectedLanguage){
      case "한국어" :
        selectedLanguageNum = 1;
        break;
      case "ENG" :
        selectedLanguageNum = 2;
        break;
      case "中國語" :
        selectedLanguageNum = 3;
        break;
      case "日本語" :
        selectedLanguageNum = 4;
        break;
      default:
        break;
    }
    //중국어
    if(selectedLanguageNum == 2) {
      switch (widget.select_value) {
        case "종로구" :
          keyword = "钟路区";
          break;
        case "중구" :
          keyword = "中区";
          break;
        case "용산구" :
          keyword = "龙山区";
          break;
        case "성동구" :
          keyword = "城东区";
          break;
        case "광진구" :
          keyword = "光津区";
          break;
        case "동대문구" :
          keyword = "东大门区";
          break;
        case "중랑구" :
          keyword = "中浪区";
          break;
        case "성북구" :
          keyword = "城北区";
          break;
        case "강북구" :
          keyword = "江北区";
          break;
        case "도봉구" :
          keyword = "道峰区";
          break;
        case "노원구" :
          keyword = "诺原区";
          break;
        case "은평구" :
          keyword = "银平区";
          break;
        case "서대문구" :
          keyword = "西大门区";
          break;
        case "마포구" :
          keyword = "麻浦区";
          break;
        case "양천구" :
          keyword = "杨川区";
          break;
        case "강서구" :
          keyword = "江西区";
          break;
        case "구로구" :
          keyword = "九老区";
          break;
        case "금천구" :
          keyword = "金泉区";
          break;
        case "영등포구" :
          keyword = "永登浦区";
          break;
        case "동작구" :
          keyword = "铜雀区";
          break;
        case "관악구" :
          keyword = "观岳区";
          break;
        case "서초구" :
          keyword = "西小区";
          break;
        case "강남구" :
          keyword = "江南区";
          break;
        case "송파구" :
          keyword = "松坡区";
          break;
        case "강동구" :
          keyword = "江东区";
          break;
        default:
          break;
      }
    }

    final response = await http.get(Uri.parse('http://10.0.2.2:8080/api/locations/search/${keyword}/${selectedLanguageNum}'));

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
        title: const Text('선택한 장소'),
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
              // CachedNetworkImage(
              //     imageUrl: widget.space_image,
              //     placeholder: (context,url) => const CircularProgressIndicator(),
              //     // errorWidget: (context,url,error) => Icon(Icons.error),
              // ),
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
                            // PageRouteBuilder(transitionDuration: const Duration(milliseconds: 1000),)
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
                                      child:
                                      Hero(
                                        tag: "cardvalue",

                                        child: CachedNetworkImage(
                                          imageUrl: items[index]['imgSrc'].toString(),
                                          placeholder: (context,url) => const CircularProgressIndicator(),
                                          // errorWidget: (context,url,error) => Icon(Icons.error),
                                        ),
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
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                width: MediaQuery.of(context).size.width*0.8,
                height: 550,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),),
                    SizedBox(height: 10,),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.linear,
                          child: Image.network(
                            image,
                            width:  300 ,
                            height: 200 ,
                            fit: BoxFit.cover,),
                        ),

                    ),
                    SizedBox(
                      height: 30,
                    ),

                    Row(

                      children:[
                        SizedBox(width: 10,),
                        Text("주소 : ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black
                        ),),

                        Expanded(
                          child: Text(address,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black
                          ),
                          maxLines: 3,
                          textAlign: TextAlign.left,
                                              ),
                        ),

                      ]
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 10,),
                        Text("인근역 : ",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black
                          ),),
                        Expanded(
                        child: Text(subway,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black
                          ),
                          maxLines: 3,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      ]
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 10,),
                        Text("설명 : ",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black
                          ),),
                        Expanded(
                        child: Text(description,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black
                          ),
                          textAlign: TextAlign.left,
                          maxLines: 5,
                        ),
                      ),
                      ]
                    ),
                    SizedBox(
                      height: 50,
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
            ),
          );
        });


  }
}

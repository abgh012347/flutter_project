import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import  'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_project/location_info.dart';

class LocationRecommandPage extends StatefulWidget {
  const LocationRecommandPage({super.key});

  @override
  State<LocationRecommandPage> createState() => _LocationRecommandPageState();
}

class _LocationRecommandPageState extends State<LocationRecommandPage> {

  int rating_time = 0;
  int secondsRemaining = 2;
  late Timer timer;
  @override
  void initState(){
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    // startTimer();
    // print(secondsRemaining);
    return Scaffold(
      appBar: AppBar(
        title: Text("구별 추천 장소",
        style: TextStyle(
          fontSize: 25,
          color: Colors.white,
        ),),
        backgroundColor: Color.fromARGB(255, 34, 163, 255),
        centerTitle: true,
      ),
      body: Stack(
        children: [
        Container(
              child : Image(image: AssetImage("images/seoul_detail.png"),
          fit: BoxFit.cover),
          color: Colors.red,
          ),
          _buildCustomWidget(1,120,110,"강서",2,170),
          _buildCustomWidget(2,70,70,"양천",55,245),
          _buildCustomWidget(3,88,88,"구로",48,285),
          _buildCustomWidget(4,77,77,"금천",95,335),
          _buildCustomWidget(5,95,95,"영등포",100,245),
          _buildCustomWidget(6,95,95,"동작",133,275),
          _buildCustomWidget(7,95,95,"관악",138,320),
          _buildCustomWidget(8,130,140,"서초",212,285),
          _buildCustomWidget(9,130,130,"강남",244,268),
          _buildCustomWidget(10,120,120,"송파",296,259),
          _buildCustomWidget(11,85,85,"강동",353,215),
          _buildCustomWidget(12,110,110,"마포",95,176),
          _buildCustomWidget(13,120,120,"은평",107,92),
          _buildCustomWidget(14,70,70,"서대문",140,170),
          _buildCustomWidget(15,100,100,"종로",180,130),
          _buildCustomWidget(16,70,70,"중",198,202),
          _buildCustomWidget(17,70,70,"용산",185,237),
          _buildCustomWidget(18,65,65,"성동",250,218),
          _buildCustomWidget(19,65,65,"동대문",261,176),
          _buildCustomWidget(20,110,110,"성북",210,120),
          _buildCustomWidget(21,100,100,"강북",210,70),
          _buildCustomWidget(22,100,100,"도봉",227,40),
          _buildCustomWidget(23,120,120,"노원",270,45),
          _buildCustomWidget(24,70,70,"중랑",305,155),
          _buildCustomWidget(25,70,70,"광진",292,218),
          ]
          ),



    );
  }
  Widget _buildCustomWidget(int num,double width, double height, String location,double x,double y)
  {
    // rating_time++;
    return AnimatedContainer(
      width: secondsRemaining == 0  ?  width : 100,
      height: secondsRemaining == 0  ?  height : 100,
      duration: Duration(seconds: 1),
      curve: Curves.elasticInOut,
      child: Image.asset("images/${location}구.png"),

      transform: secondsRemaining == 0 ? Matrix4.translationValues(x, y, 0) : num < 12 ? Matrix4.translationValues(x, y+800, 0)  : Matrix4.translationValues(x, -y-200, 0) ,

    );
  }

  void startTimer(){
    timer = Timer.periodic(Duration(seconds: 1), (Timer t){
      setState(() {
        print(secondsRemaining);
        if(secondsRemaining == 0){
          print("타이머 죽임");
          t.cancel();
        }
        else{
          secondsRemaining--;
          timer.isActive ? '타이머 실행중' : '타이머 죽음';

        }
      });
    });
  }
}
Future<LocationInfo> fetchData() async{
  final response = await http.get(Uri.parse("http://10.0.2.2:8080/api/login"));
  if(response.statusCode == 200){
    return LocationInfo.fromJson(json.decode(response.body));
  }
  else{
    throw Exception("추천 장소를 불러오는데 실패하였습니다.");
  }
}


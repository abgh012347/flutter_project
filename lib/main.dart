import 'package:flutter/material.dart';
import './start.dart';
import './best_recommand.dart';
import './location_recommand.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/':(context)=>LocationRecommandPage(),
        '/best_recommand':(context)=>BestRecommandPage(),
        '/location_recommand':(context)=>StartPage(),
      }
    );
  }
}


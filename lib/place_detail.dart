import 'package:flutter/material.dart';

import 'location_info.dart'; // LocationInfo 클래스 import

class PlaceDetail extends StatelessWidget {
  final LocationInfo locationInfo;

  const PlaceDetail({super.key, required this.locationInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(locationInfo.place_name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(locationInfo.img_src),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '주소: ${locationInfo.place_description}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '인근역: ${locationInfo.place_subway}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '설명: ${locationInfo.place_description}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // 창 닫기
                    },
                    child: const Text("닫기"),
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
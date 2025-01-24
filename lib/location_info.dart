class LocationInfo{
  final String place_name;
  final String place_description;
  final String img_src;
  final String place_subway;

  LocationInfo({ required this.place_name, required
  this.place_description, required this.img_src, required this.place_subway});

  factory LocationInfo.fromJson(Map<String,dynamic> json){
    return LocationInfo(

      place_name: json['place_name'],
      place_description: json['place_description'],
      img_src: json['img_src'],
      place_subway: json['place_subway'],
    );
  }
}


class LocationInfo{
  final int id;
  final String locationName;
  final String imgUrl;

  LocationInfo({required this.id,required this.locationName,required this.imgUrl});

  factory LocationInfo.fromJson(Map<String,dynamic> json){
    return LocationInfo(
        id: json['id'],
        locationName: json['locationName'],
        imgUrl: json['imgUrl'],
        // balance: json['balance']
    );
  }
}


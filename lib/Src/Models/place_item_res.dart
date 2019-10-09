class PlaceItemRes {
  String name;
  String address;
  double lat;
  double lng;

  PlaceItemRes(
    this.name,
    this.address,
    this.lat,
    this.lng,
  );

  static List<PlaceItemRes> fromJson(Map<String, dynamic> json) {
    print("parse date");
    List<PlaceItemRes> list = new List();
    var results = json["results"] as List;

    for (var item in results) {
      PlaceItemRes itemRes = PlaceItemRes(
        item["name"],
        item["formatted_address"],
        item["geometry"]["location"]["lat"],
        item["geometry"]["location"]["lng"],
      );
      list.add(itemRes);
    }
    return list;
  }
}

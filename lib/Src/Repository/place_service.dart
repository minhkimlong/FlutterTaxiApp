import 'dart:async';
import 'dart:convert';
import 'package:taxi_app/Src/Models/place_item_res.dart';
import 'package:http/http.dart' as http;

class PlaceService {
  static Future<List<PlaceItemRes>> searchPlace(String keyword) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?key=" +
            "AIzaSyBD_wffJpgFav8eQXQnaa7U_MKKvl0X_BE" +
            "&language=vi&region=VN&query=" +
            Uri.encodeQueryComponent(keyword);

    var res = await http.get(url);
    if (res.statusCode == 200) {
      return PlaceItemRes.fromJson(json.decode(res.body));
    } else {
      return List();
    }
  }
}

import 'dart:async';
import 'package:taxi_app/Src/Repository/place_service.dart';

class PlaceBloc {
  StreamController _placeSearchController = StreamController();

  Stream get placeSearchStream => _placeSearchController.stream;

  void searchPlaceBloc(String keyword) {
    print("Place bloc search" + keyword);

    _placeSearchController.sink.add("start");
    PlaceService.searchPlace(keyword).then((res) {
      _placeSearchController.sink.add(res);
    }).catchError((err) {
      print(err);
      _placeSearchController.sink.add("stop");
    });
  }

  void dispose() {
    _placeSearchController.close();
  }
}

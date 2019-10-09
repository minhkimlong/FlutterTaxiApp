import 'package:flutter/material.dart';
import 'package:taxi_app/Src/Blocs/place_bloc.dart';
import 'package:taxi_app/Src/Models/place_item_res.dart';

class RidePickerPage extends StatefulWidget {
  final String selectedAddress;
  final Function(PlaceItemRes, bool) onSelected;
  final bool isFromAddress;

  RidePickerPage(
    this.selectedAddress,
    this.onSelected,
    this.isFromAddress,
  );

  @override
  _RidePickerPageState createState() => _RidePickerPageState();
}

class _RidePickerPageState extends State<RidePickerPage> {
  var _placeSearchController;
  PlaceBloc placeBloc = PlaceBloc();

  @override
  void initState() {
    _placeSearchController =
        TextEditingController(text: widget.selectedAddress);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Choose your direction",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 10),
              width: double.infinity,
              height: 60,
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: <Widget>[
                    SizedBox(
                      width: 40,
                      height: 60,
                      child: Center(
                        child: Icon(Icons.location_on),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: FlatButton(
                        onPressed: () => _placeSearchController.text = "",
                        child: SizedBox(
                          height: 60,
                          width: 40,
                          child: SizedBox(
                            width: 40,
                            height: 60,
                            child: Center(
                              child: Icon(Icons.close),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 40,
                        right: 50,
                      ),
                      child: TextFormField(
                        controller: _placeSearchController,
                        textInputAction: TextInputAction.search,
                        onFieldSubmitted: (str) =>
                            placeBloc.searchPlaceBloc(str),
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green,
                              width: 2,
                            ),
                          ),
                          labelText: "Your Address",
                          labelStyle: TextStyle(
                            color: Colors.green,
                            fontSize: 18,
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: placeBloc.placeSearchStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data.toString());
                    if (snapshot.data == "start") {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    List<PlaceItemRes> places = snapshot.data;
                    return Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: places.length,
                        separatorBuilder: (context, index) => Divider(
                          height: 1,
                          color: Color(0xfff5f5f5),
                        ),
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              (places[index].name == null)
                                  ? null
                                  : places[index].name,
                            ),
                            subtitle: Text(
                              (places[index].address == null)
                                  ? null
                                  : places[index].address,
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                              widget.onSelected(
                                places[index],
                                widget.isFromAddress,
                              );
                            },
                          );
                        },
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:cilpacastra/pages/detail/budaya/detail_budaya.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong/latlong.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_location/user_location.dart';
import 'package:http/http.dart' as http;

class LokasiPage extends StatefulWidget {
  @override
  _LokasiPageState createState() => _LokasiPageState();
}

class _LokasiPageState extends State<LokasiPage> {
  MapController mapController = MapController();
  TextEditingController controllerAddress = TextEditingController();
  List<Marker> markers = [];

  Position _currentPosition;
  var latitude;
  var longitude;
  var first;

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  TextEditingController _textFieldController = TextEditingController();

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      // print(e);
    });

    Future.delayed(Duration(seconds: 2), () {
      _getAddress();
    });
  }

  updateLocation(latitude, longitude) {
    setState(() {
      latitude = latitude;
      longitude = longitude;
    });
  }

  // List listDataBudaya = [];
  // Future<List> _dataBudaya() async {
  //   var url = "http://cilpacastra.snip-id.com/api/data-budaya";
  //   final response = await http.get(url, headers: {
  //     'Accept': 'application/json',
  //   });
  //   Map<String, dynamic> _listBudaya;

  //   _listBudaya = json.decode(response.body);
  //   setState(() {
  //     listDataBudaya = _listBudaya['data_budaya'];
  //   });
  // }

  List markers_ = [];
  Future<List> _dataBudaya() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = "http://cilpacastra.snip-id.com/api/data-budaya";
    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + prefs.getString('token').toString()
    });
    Map<String, dynamic> _markers;

    _markers = json.decode(response.body);
    setState(() {
      markers_ = _markers['data_budaya'];
      var i = 0;
      if (markers_ != null) {
        while (i <= markers_.length) {
          var title = markers_[i]['nama_budaya'];
          var description = markers_[i]['nama_daerah'];
          var data = markers_[i];
          var id = markers_[i]['id'].toString();
          markers.add(
            Marker(
                width: 160.0,
                height: 130.0,
                point: LatLng(markers_[i]['lat'], markers_[i]['lng']),
                builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailBudaya(id, data)));
                    },
                    child: Container(
                      transform: Matrix4.translationValues(0, -30, 0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(title.toString(),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                                Text(description.toString(),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                          Icon(
                            FontAwesome.map_marker,
                            color: Colors.red,
                            size: 50,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          );
          i++;
        }
      }
    });
  }

  _getAddress() async {
    final coordinates =
        Coordinates(controller.center.latitude, controller.center.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    setState(() {
      first = addresses.first;
      _textFieldController.text = first.addressLine.toString();
    });
  }

  MapController controller = MapController();

  void initState() {
    super.initState();
    _getCurrentLocation();
    _dataBudaya();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          FlutterMap(
            mapController: controller,
            options: MapOptions(
              center: _currentPosition == null
                  ? LatLng(-1.2379255, 116.8528605)
                  : LatLng(
                      _currentPosition.latitude, _currentPosition.longitude),
              zoom: 10.0,
              plugins: [
                UserLocationPlugin(),
              ],
            ),
            layers: [
              TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c']),
              MarkerLayerOptions(markers: markers),
              UserLocationOptions(
                context: context,
                mapController: mapController,
                markers: markers,
                showMoveToCurrentLocationFloatingActionButton: false,
              )
            ],
          ),
          Positioned(
            top: 50,
            left: 20,
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 10.0, // has the effect of softening the shadow
                  spreadRadius: 5.0, // has the effect of extending the shadow
                  offset: Offset(
                    0.0, // horizontal, move right 10
                    0.0, // vertical, move down 10
                  ),
                ),
              ], color: Colors.white, borderRadius: BorderRadius.circular(50)),
              height: 50,
              width: 50,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  double zoom = 15.0; //the zoom you want
                  controller.move(
                      LatLng(_currentPosition.latitude,
                          _currentPosition.longitude),
                      zoom);
                });
              },
              child: Container(
                height: 50,
                width: 50,
                decoration:
                    BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                child: Icon(
                  Icons.my_location,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

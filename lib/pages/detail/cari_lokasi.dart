import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong/latlong.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_location/user_location.dart';

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
              zoom: 15.0,
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

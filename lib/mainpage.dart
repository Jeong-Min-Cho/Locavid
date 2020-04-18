import 'package:flutter/material.dart';

import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_beautiful_popup/main.dart';

import 'package:location/location.dart';

import 'package:google_map_polyline/google_map_polyline.dart';

import 'package:extended_navbar_scaffold/extended_navbar_scaffold.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Set<Marker> markers = {};
  // this will hold the generated polylines
  final Set<Polyline> polyline = {};

  Completer<GoogleMapController> _controller = Completer();

  //GoogleMapController _controller2;

  List<List<LatLng>> routesCollection;

  List<LatLng> routeCoords;
  List<LatLng> routeCoords2;
  List<LatLng> routeCoords3;
  GoogleMapPolyline googleMapPolyline =
      new GoogleMapPolyline(apiKey: "AIzaSyDvcAyoUGWsegpT_SsSN3S7orGaGam2kaM");


  void _showAlert(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Info'),
          content: Text("This app tracks your location,"
              " but your data will not public until you have tested positive "
              "for the virus. If you don't want the app to track your location"
              " in specific locaitons, "
              "please press the do don't track here button."),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        )
    );
//    Navigator.pop(context);
  }


  getsomePoints() async {
    routeCoords = await googleMapPolyline.getCoordinatesWithLocation(
        origin: LatLng(38.833799, -77.313717),
        destination: LatLng(38.756273, -77.523046),
        mode: RouteMode.driving);

    routeCoords2 = await googleMapPolyline.getCoordinatesWithLocation(
        origin: LatLng(38.756273, -77.523046),
        destination: LatLng(38.771544, -77.506261),
        mode: RouteMode.driving);
    //38.771544, -77.506261 - Mannassas mall

    routeCoords2 = await googleMapPolyline.getCoordinatesWithLocation(
        origin: LatLng(38.771544, -77.506261),
        destination: LatLng(38.836880, -77.438502),
        mode: RouteMode.driving);
  }

  @override
  void initState() {
    super.initState();

    // Call the initial alert on page build
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _showAlert(context));

//    await getsomePoints();

    //38.771544, -77.506261 - Mannassas mall

    Marker resultMarker = Marker(
      markerId: MarkerId('testt'),
      infoWindow: InfoWindow(
          title: "GMU Manassas Campus", snippet: "Stayed: 3 hour(s)"),
      position: LatLng(38.836880, -77.438502),
    );

    markers.add(resultMarker);

    Marker resultMarker2 = Marker(
      markerId: MarkerId('testt'),
      infoWindow: InfoWindow(
          title: "Mannassas mall", snippet: "Stayed: 2 hour(s)"),
      position: LatLng(38.771544, -77.506261),
    );

    markers.add(resultMarker2);
  }

  static final CameraPosition _gmuLocation = CameraPosition(
    target: LatLng(38.827524, -77.305230),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  var dontTrackButton = (
      Container(
        margin: EdgeInsets.fromLTRB(0, 0, 40, 0),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.blue,
          onPressed: () {},
          label: Text("Don't track here"),
          heroTag: null,
        ),
      )
  );

  var testedPositiveButton = (
      Container(
        margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
        child: FloatingActionButton.extended(
          heroTag: null,
          backgroundColor: Colors.red,
          onPressed: () {},
          label: Text("Tested Positive")
        ),
      )
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: testedPositiveButton,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: dontTrackButton
          ),
        ],
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _gmuLocation,
        //myLocationEnabled: true,
        markers: markers
      )
    );

  }

  void removeMarker() {
    //markers.removeAll(Marker());
  }
}

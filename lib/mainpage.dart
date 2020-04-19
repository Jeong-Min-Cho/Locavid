import 'package:flutter/material.dart';

import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:developer';

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
    final prefs = await SharedPreferences.getInstance();

    // only show the alert if it wasn't showed to the user before
    bool alertViewed = prefs.getBool('alert_viewed') == null ? false : true;

    if (!alertViewed) {
      prefs.setBool('alert_viewed', true);

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
              ));
    }
  }

  @override
  void initState() {
    super.initState();

  }

  static final CameraPosition _gmuLocation = CameraPosition(
    target: LatLng(38.827524, -77.305230),
    zoom: 14.4746,
  );

  var dontTrackButton = (Container(
    child: FloatingActionButton.extended(
      backgroundColor: Colors.blue,
      onPressed: () {},
      label: Text("Don't track here"),
      heroTag: null,
    ),
  ));

  var testedPositiveButton = (Container(
    child: FloatingActionButton.extended(
        heroTag: null,
        backgroundColor: Colors.red,
        onPressed: () {},
        label: Text("Tested Positive")),
  ));

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(30, 50, 0, 0),
            child: Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton.extended(
                  icon: Icon(Icons.map),
                  backgroundColor: Colors.green,
                  onPressed: () => Navigator.pushNamed(context, '/worldmap'),
                  label: Text("Global Map")),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: testedPositiveButton,
            ),
          ),
          Container(
              padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
              child: Align(
                  alignment: Alignment.bottomRight, child: dontTrackButton)),
        ],
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _gmuLocation,
        markers: markers,
        polylines: polyline,
        onMapCreated: (GoogleMapController controller) {
          setState(() {
            _controller.complete(controller);
          });
        },
      ),
    );
  }

  Future<void> _goToTheLake() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    } 

    _locationData = await location.getLocation();

    setState(() {
      polyline.add(Polyline(
          polylineId: PolylineId('route3'),
          visible: true,
          points: routeCoords3,
          width: 4,
          color: Colors.red,
          startCap: Cap.roundCap,
          endCap: Cap.buttCap));
    });
  }
}

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

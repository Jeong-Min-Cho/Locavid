import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_beautiful_popup/main.dart';

//import 'package:location/location.dart';

import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:developer';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {

  final firebase = FirebaseDatabase.instance;

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

    if(!alertViewed) {
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

  getsomePoints() async {
    routeCoords = await googleMapPolyline.getCoordinatesWithLocation(
        origin: LatLng(38.833799, -77.313717),
        destination: LatLng(38.756273, -77.523046),
        mode: RouteMode.driving);

    routeCoords2 = await googleMapPolyline.getCoordinatesWithLocation(
        origin: LatLng(38.756273, -77.523046),
        destination: LatLng(38.771544, -77.506261),
        mode: RouteMode.driving);

    routeCoords3 = await googleMapPolyline.getCoordinatesWithLocation(
        origin: LatLng(38.771544, -77.506261),
        destination: LatLng(38.836880, -77.438502),
        mode: RouteMode.driving);

  }

  @override
  void initState() {
    super.initState();

    // Call the initial alert on page build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showAlert(context);
      _centerOnUser();
    });

    getsomePoints();

    Marker resultMarker = Marker(
      markerId: MarkerId('testt2'),
      infoWindow:
          InfoWindow(title: "Centreville Plaza", snippet: "Stayed: 2 hour(s)"),
      position: LatLng(38.836880, -77.438502),
    );

    markers.add(resultMarker);

    Marker resultMarker2 = Marker(
      markerId: MarkerId('testt3'),
      infoWindow:
          InfoWindow(title: "Mannassas mall", snippet: "Stayed: 2 hour(s)"),
      position: LatLng(38.771544, -77.506261),
    );

    markers.add(resultMarker2);

    _trackUserLocation();
  }

  static final CameraPosition defaultLocation = CameraPosition(
    target: LatLng(38.827524, -77.305230),
    zoom: 10,
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

  Widget renderGlobalMapButton(context) {
    return (Container(
      child: FloatingActionButton.extended(
          icon: Icon(Icons.map),
          backgroundColor: Colors.green,
          onPressed: () => Navigator.pushNamed(context, '/worldmap'),
          label: Text("Global Map")),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(30, 50, 0, 0),
            child: Align(
                alignment: Alignment.topRight,
               child: renderGlobalMapButton(context))
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
        initialCameraPosition: defaultLocation,
        //myLocationEnabled: true,
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

  void removeMarker() {
    //markers.removeAll(Marker());
  }

  Future<void> _centerOnUser() async {

    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    final GoogleMapController controller = await _controller.future;


    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 17)));
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    } 


    Marker marker = Marker(
      markerId: MarkerId('sup'),
      infoWindow:
      InfoWindow(title: "Your Location"),
      position: LatLng(position.latitude, position.longitude),
    );

    setState(() {
      markers.add(marker);
    });

      polyline.add(Polyline(
          polylineId: PolylineId('route3'),
          visible: true,
          points: routeCoords3,
          width: 4,
          color: Colors.red,
          startCap: Cap.roundCap,
          endCap: Cap.buttCap));
    }

  Timer timer;

    Future<void> _trackUserLocation() async {

    int counter = 0;
// snapshot._data[1].value[.length];
    firebase.reference().child('test').once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> map = snapshot.value;
      counter = map.length;
    });

     timer = Timer.periodic(new Duration(seconds: 10), (timer) async {

        Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

        final GoogleMapController controller = await _controller.future;

        controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 17)));

        var date = new DateTime.now();
        String formattedTime =
            '${date.month}/${date.day}/${date.year} ${date.hour}:${date.minute}';



        Marker marker = Marker(
          markerId: MarkerId(counter.toString()),
          infoWindow:
            InfoWindow(title: formattedTime),
             position: LatLng(position.latitude, position.longitude),
        );

        firebase.reference().child("test").child(counter.toString()).set({
          'latitude': position.latitude,
          'longitude': position.longitude,
          'time': formattedTime
        });

        counter++;

        setState(() {
          markers.add(marker);
        });
      });
    }


  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }
}

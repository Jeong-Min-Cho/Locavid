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


   // routeCoords3.addAll([LatLng(38.833799, -77.313717), LatLng(38.756273, -77.523046)]);
    //routeCoords3.ad
   // routeCoords3.add(LatLng(38.756273, -77.523046));


    routeCoords3 = await googleMapPolyline.getCoordinatesWithLocation(
        origin: LatLng(38.771544, -77.506261),
        destination: LatLng(38.836880, -77.438502),
        mode: RouteMode.driving);

    //38.836880, -77.438502 centreville plaza

    //routesCollection.add(routeCoords);
    //routesCollection.add(routeCoords2);

    // markers.add(Marker(
    //       markerId: MarkerId('testlocation'),
    //       position: LatLng(38.756273, -77.523046),
    //       onTap: () {}));
  }

  @override
  void initState() {
    super.initState();

    // Call the initial alert on page build
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _showAlert(context));

    getsomePoints();


    Marker resultMarker = Marker(
      markerId: MarkerId('testt2'),
      infoWindow: InfoWindow(
          title: "Centreville Plaza", snippet: "Stayed: 2 hour(s)"),
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



    // Marker resultMarker0 = Marker(
    //   markerId: MarkerId('testt1'),
    //   infoWindow: InfoWindow(
    //       title: "GMU Manassas Campus", snippet: "Stayed: 4 hour(s)"),
    //   position: LatLng(38.756273, -77.523046),
    // );

    // markers.add(resultMarker0);

    //38.771544, -77.506261 - Mannassas mall

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
        markers: markers,
        polylines: polyline,
        onMapCreated: (GoogleMapController controller) {
          setState(() {
            //  _controller2 = controller;
            _controller.complete(controller);


            // polyline.add(Polyline(
            //     polylineId: PolylineId('route1'),
            //     visible: true,
            //     points: routeCoords,
            //     width: 4,
            //     color: Colors.blue,
            //     startCap: Cap.roundCap,
            //     endCap: Cap.buttCap));


          });
        },
      )
    );
  }

  final parallaxCardItemsList = <ParallaxCardItem>[
    ParallaxCardItem(
        title: 'Some Random Route 1',
        body: 'Place 1',
        background: Container(
          color: Colors.orange,
        )),
    ParallaxCardItem(
        title: 'Some Random Route 2',
        body: 'Place 2',
        background: Container(
          color: Colors.redAccent,
        )),
    ParallaxCardItem(
        title: 'Some Random Route 3',
        body: 'Place 1',
        background: Container(
          color: Colors.blue,
        )),
  ];

  void popup() {
    setState(() {
      final popup = BeautifulPopup(
        context: context,
        template: TemplateFail,
      );
      popup.show(
        title: 'Information',
        content: 'YAYYYYYYYYYYYYYYYYY3Y7',
        actions: [
          popup.button(
              label: 'Do Not Track Here',
              onPressed: () {
                markers.clear();
              }),
          popup.button(
            label: 'Close',
            onPressed: Navigator.of(context).pop,
          ),
        ],
      );
    });
  }

  void removeMarker() {
    //markers.removeAll(Marker());
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
      markers.add(Marker(
          markerId: MarkerId('mylocation'),
          position: LatLng(_locationData.latitude, _locationData.longitude),
          onTap: () => popup()));




            polyline.add(Polyline(
                        polylineId: PolylineId('route3'),
                        visible: true,
                        points: routeCoords3,
                        width: 4,
                        color: Colors.red,
                        startCap: Cap.roundCap,
                        endCap: Cap.buttCap));
    });

    // final GoogleMapController controller = await _controller.future;

    // controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
    //     target: LatLng(_locationData.latitude, _locationData.longitude),
    //     zoom: 19.151926040649414)));
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

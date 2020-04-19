import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';

import 'package:google_map_polyline/google_map_polyline.dart';

import 'package:random_color/random_color.dart';

class WorldMap extends StatefulWidget {
  @override
  State<WorldMap> createState() => WorldMapState();
}

class WorldMapState extends State<WorldMap> {
  Completer<GoogleMapController> _controller = Completer();

  GoogleMapPolyline googleMapPolyline =
      new GoogleMapPolyline(apiKey: "AIzaSyDvcAyoUGWsegpT_SsSN3S7orGaGam2kaM");

  Set<Marker> markers = {};
  Set<Polyline> lines = {};
  //38.897438, -77.036587 White House
  static final CameraPosition _whiteHouse = CameraPosition(
    target: LatLng(38.897438, -77.036587),
    zoom: 13.5,
  );

  getsomePoints(LatLng origin, LatLng des, int polyid) async {
    var temp = await googleMapPolyline.getCoordinatesWithLocation(
        origin: origin, destination: des, mode: RouteMode.walking);

    RandomColor _randomColor = RandomColor();

    Color _color = _randomColor.randomColor();
    setState(() {
      lines.add(Polyline(
          polylineId: PolylineId('testr' + polyid.toString()),
          visible: true,
          points: temp,
          width: 3,
          color: _color,
          startCap: Cap.roundCap,
          endCap: Cap.buttCap));
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
     // _centerOnUser();
    });
    var whiteHouse = LatLng(38.897438, -77.036587);



    markers.add(Marker(
        markerId: MarkerId('mylocation'),
        infoWindow: InfoWindow(title: 'White House', snippet: 'hello'),
        position: LatLng(38.897438, -77.036587),
        onTap: () => {}));

    for (int j = 0; j < 50; j++) {
      var rng = new Random(); // Random Dummy Data

      double negative = 1.0;
      if (rng.nextInt(1) == 0) {
        negative *= -1.0;
      }

      double tempd = (rng.nextInt(200000) % 200000 + (-100000)) * 0.0000003;
      double tempd2 = (rng.nextInt(200000) % 200000 + (-100000)) * 0.0000003;
      tempd *= negative;

      getsomePoints(
          LatLng(whiteHouse.latitude + tempd,
              whiteHouse.longitude + (1 / 40).toDouble() * negative),
          LatLng(whiteHouse.latitude + tempd2,
              whiteHouse.longitude + (1 / 40).toDouble()),
          j);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _whiteHouse,
        markers: markers,
        polylines: lines,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.fromLTRB(30, 50, 0, 0),
        child: Align(
          alignment: Alignment.topRight,
          child: FloatingActionButton.extended(
              icon: Icon(Icons.map),
              backgroundColor: Colors.blueAccent,
              onPressed: () => Navigator.pushNamed(context, '/mainpage'),
              label: Text("Personal Map")),
        ),
      ),
    );
  }


  Future<void> _centerOnUser() async {

    final GoogleMapController controller = await _controller.future;

    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 13)));
  }

}

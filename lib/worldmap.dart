import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';

import 'package:google_map_polyline/google_map_polyline.dart';

class WorldMap extends StatefulWidget {
  @override
  State<WorldMap> createState() => WorldMapState();
}

class WorldMapState extends State<WorldMap> {
  Completer<GoogleMapController> _controller = Completer();

  List<LatLng> routeCoords;

  GoogleMapPolyline googleMapPolyline =
      new GoogleMapPolyline(apiKey: "AIzaSyDvcAyoUGWsegpT_SsSN3S7orGaGam2kaM");

  Set<Marker> markers = {};
  Set<Polyline> lines = {};
  //38.897438, -77.036587 White House
  static final CameraPosition _whiteHouse = CameraPosition(
    target: LatLng(38.897438, -77.036587),
    zoom: 12.0,
  );

  getsomePoints(LatLng origin, LatLng des, int polyid) async {
    var temp = await googleMapPolyline.getCoordinatesWithLocation(
        origin: origin, destination: des, mode: RouteMode.driving);

        print('are we here ?');
       List listColors = [
      Colors.indigo[100],
      Colors.amber[100],
      Colors.black,
      Colors.blue[100],
      Colors.red[100],
      Colors.orange[100],
      Colors.green[100],
      Colors.deepOrange[100],
      Colors.white,
      Colors.green[100]
    ];

      setState(() {
        lines.add(Polyline(
          polylineId: PolylineId('testr'+polyid.toString()),
          visible: true,
          points: temp,
          width: 2,
          color: Colors.red[300],
          startCap: Cap.roundCap,
          endCap: Cap.buttCap));
      });
        
  }

  @override
  void initState() {
    super.initState();

    markers.add(Marker(
        markerId: MarkerId('mylocation'),
        infoWindow: InfoWindow(title: 'White House', snippet: 'hello'),
        position: LatLng(38.897438, -77.036587),
        onTap: () => {}));
   

    for (int j = 0; j < 5; j++) {
      //Color tempColor = listColors[j];
      Polyline temp = new Polyline(
        points: [],
        endCap: Cap.squareCap,
        width: 2,
        color: Colors.grey,
        geodesic: false,
        polylineId: PolylineId("line_one"),
      );
      //int randomNum = rng.nextInt(200000) % 200000 + (-100000);
      var rng = new Random(); // Random Dummy Data

      double negative = 1.0;
      if (rng.nextInt(1) == 0)
      {
        negative *= -1.0;

      }

      // for (var i = 0; i < 2; i++) {
      //   double tempd = (rng.nextInt(200000) % 200000 + (-100000)) * 0.000001;
      //   temp.points.add(LatLng(38.988827 + tempd, -77.472091 + (i / 40).toDouble()));

      //   //print('added' + (38.988827 + tempd).toString() + ' / ' + (-77.472091+ tempd).toString());
      // }
        double tempd = (rng.nextInt(200000) % 200000 + (-100000)) * 0.000005;

        double tempd2 = (rng.nextInt(200000) % 200000 + (-100000)) * 0.000005;

        tempd*= negative;
        tempd2*= negative;

//38.897438, -77.036587

      getsomePoints(LatLng(38.897438 + tempd, -77.036587 + (1 / 40).toDouble()) , LatLng(38.897438 + tempd2, -77.036587 + (1 / 40).toDouble()), j);
      


      //print('Length ' + temp.points.length.toString());
     // lines.add(temp);
    }
    // lines.add(
    //   Polyline(
    //     points: [
    //       LatLng(38.988827, -77.472091),
    //       LatLng(38.980821, -77.470815),
    //       LatLng(38.969406, -77.471301)
    //     ],
    //     endCap: Cap.squareCap,
    //     width: 2,
    //     geodesic: false,
    //     polylineId: PolylineId("line_one"),
    //   ),
    // );

    // lines.add(
    //   Polyline(
    //     points: [LatLng(38.949798, -77.470534), LatLng(38.938614, -77.469379)],
    //     color: Colors.amber,
    //     width: 2,
    //     polylineId: PolylineId("line_one"),
    //   ),
    // );
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

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    //controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}

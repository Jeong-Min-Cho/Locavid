import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';

class WorldMap extends StatefulWidget {
  @override
  State<WorldMap> createState() => WorldMapState();
}

class WorldMapState extends State<WorldMap> {
  Completer<GoogleMapController> _controller = Completer();

  Set<Marker> markers = {};
  Set<Polyline> lines = {};
  //38.897438, -77.036587 White House
  static final CameraPosition _whiteHouse = CameraPosition(
    target: LatLng(38.897438, -77.036587),
    zoom: 13.0,
  );

  @override
  void initState() {
    super.initState();

    markers.add(Marker(
        markerId: MarkerId('mylocation'),
        infoWindow: InfoWindow(title: 'title', snippet: 'hello'),
        position: LatLng(38.988827, -77.472091),
        onTap: () => {}));

    for (int j = 0; j < 10; ++j) {
      //List<Colors> listColors = { Colors.accents, Colors.amber, Colors.black, Colors.blue, Colors.red, Colors.orange, Colors.green, Colors.deepOrange, Colors.white, Colors.green}; 

      Polyline temp = new Polyline(
        points: [],
        endCap: Cap.squareCap,
        width: 2,
        color: Colors.black,
        geodesic: false,
        polylineId: PolylineId("line_one"),
      );
      //int randomNum = rng.nextInt(200000) % 200000 + (-100000);
      var rng = new Random(); // Random Dummy Data
      for (var i = 0; i < 10; i++) {
        double tempd = (rng.nextInt(200000) % 200000 + (-100000)) * 0.000001;
        temp.points
            .add(LatLng(38.988827 + tempd, -77.472091 + (i / 40).toDouble()));

        //print('added' + (38.988827 + tempd).toString() + ' / ' + (-77.472091+ tempd).toString());
      }

      //print('Length ' + temp.points.length.toString());
      lines.add(temp);
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

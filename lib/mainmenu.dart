import 'package:flutter/material.dart';

import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_beautiful_popup/main.dart';

import 'package:location/location.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_map_polyline/google_map_polyline.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}






class MapSampleState extends State<MapSample> {

  Set<Marker> markers = Set();
  // this will hold the generated polylines
  final Set<Polyline> polyline = {};


  Completer<GoogleMapController> _controller = Completer();
  //GoogleMapController _controller2;
  List<LatLng> routeCoords;
  GoogleMapPolyline googleMapPolyline =
      new GoogleMapPolyline(apiKey: "AIzaSyDvcAyoUGWsegpT_SsSN3S7orGaGam2kaM");

  
    getsomePoints() async {

      routeCoords = await googleMapPolyline.getCoordinatesWithLocation(
          origin: LatLng(38.833799, -77.313717),
          destination: LatLng(38.756273, -77.523046),
          mode: RouteMode.driving);

  }


  @override
  void initState() { 
    super.initState();
    getsomePoints();
    
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
        

            polyline.add(Polyline(
          polylineId: PolylineId('route1'),
          visible: true,
          points: routeCoords,
          width: 4,
          color: Colors.blue,
          startCap: Cap.roundCap,
          endCap: Cap.buttCap));
          });
          
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('My Location'),
        icon: Icon(Icons.data_usage),
      ),
    );
  }


       
    
  void popup()
  {
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
                  onPressed: ()   {
                     markers.clear();

                  }
                ),

                popup.button(
                  label: 'Close',
                  onPressed: Navigator.of(context).pop,
                ),
              ],
            );
    });
                
    
  }

  void removeMarker()
  {
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
          onTap: () => popup()

          )
          
          );

    });
    
    final GoogleMapController controller = await _controller.future;
    

    

    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(_locationData.latitude, _locationData.longitude),
        zoom: 19.151926040649414
      )));

  }



}
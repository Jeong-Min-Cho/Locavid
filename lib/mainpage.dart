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

    // routeCoords3 = await googleMapPolyline.getCoordinatesWithLocation(
    //     origin: LatLng(38.771544, -77.506261),
    //     destination: LatLng(38.836880, -77.438502),
    //     mode: RouteMode.driving);

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
    getsomePoints();

    // Marker resultMarker0 = Marker(
    //   markerId: MarkerId('testt1'),
    //   infoWindow: InfoWindow(
    //       title: "GMU Manassas Campus", snippet: "Stayed: 4 hour(s)"),
    //   position: LatLng(38.756273, -77.523046),
    // );

    // markers.add(resultMarker0);

    //38.771544, -77.506261 - Mannassas mall

    // Marker resultMarker = Marker(
    //   markerId: MarkerId('testt2'),
    //   infoWindow: InfoWindow(
    //       title: "Centreville Plaza", snippet: "Stayed: 2 hour(s)"),
    //   position: LatLng(38.836880, -77.438502),
    // );

    // markers.add(resultMarker);

    Marker resultMarker2 = Marker(
      markerId: MarkerId('testt3'),
      infoWindow:
          InfoWindow(title: "Mannassas mall", snippet: "Stayed: 2 hour(s)"),
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

  @override
  Widget build(BuildContext context) {
    return new ExtendedNavigationBarScaffold(
      elevation: 0,
      floatingAppBar: true,
      appBar: AppBar(
        shape: kAppbarShape,
        leading: IconButton(
          icon: Icon(
            Icons.data_usage,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        title: Text(
          'Search a Location',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      navBarColor: Colors.white,
      navBarIconColor: Colors.black,
      moreButtons: [
        MoreButtonModel(
          icon: Icons.map,
          label: 'GlobalMap',
          onTap: () {},
        ),
        MoreButtonModel(
          icon: Icons.directions_run,
          label: 'My Paths',
          onTap: () {},
        ),
        MoreButtonModel(
          icon: Icons.contacts,
          label: 'Contacts',
          onTap: () {},
        ),
        MoreButtonModel(
          icon: Icons.local_hospital,
          label: 'Got Infected',
          onTap: () {},
        ),
        MoreButtonModel(
          icon: Icons.help,
          label: 'App Help',
          onTap: () {},
        ),
        MoreButtonModel(
          icon: Icons.portrait,
          label: 'Profile',
          onTap: () {},
        ),
        null,
        MoreButtonModel(
          icon: Icons.settings,
          label: 'Settings',
          onTap: () {},
        ),
        null,
      ],
      searchWidget: Container(
        height: 50,
        color: Colors.redAccent,
      ),
      // onTap: (button) {},
      // currentBottomBarCenterPercent: (currentBottomBarParallexPercent) {},
      // currentBottomBarMorePercent: (currentBottomBarMorePercent) {},
      // currentBottomBarSearchPercent: (currentBottomBarSearchPercent) {},
      parallexCardPageTransformer: PageTransformer(
        pageViewBuilder: (context, visibilityResolver) {
          return PageView.builder(
            controller: PageController(viewportFraction: 0.85),
            itemCount: parallaxCardItemsList.length,
            itemBuilder: (context, index) {
              final item = parallaxCardItemsList[index];
              final pageVisibility =
                  visibilityResolver.resolvePageVisibility(index);
              return ParallaxCardsWidget(
                item: item,
                pageVisibility: pageVisibility,
              );
            },
          );
        },
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

            polyline.add(Polyline(
                polylineId: PolylineId('route1'),
                visible: true,
                points: routeCoords,
                width: 4,
                color: Colors.blue,
                startCap: Cap.roundCap,
                endCap: Cap.buttCap));

            polyline.add(Polyline(
                polylineId: PolylineId('route2'),
                visible: true,
                points: routeCoords2,
                width: 4,
                color: Colors.red,
                startCap: Cap.roundCap,
                endCap: Cap.buttCap));
          });
        },
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: Text('My Location'),
      //   icon: Icon(Icons.data_usage),
      // ),
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
    });

    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(_locationData.latitude, _locationData.longitude),
        zoom: 19.151926040649414)));
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

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import '../components/drawer_component.dart';
import '../services/maps_service.dart';

class MapsScreen extends StatefulWidget {
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {

  bool loading = true;
  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};
  final LatLng _currentPosition = LatLng(38, -97);
  final List<LatLng> markerLocations = [];

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  getCountryCases() async {
    final result = await MapsService().getCountry();
    print(result);
    result.forEach((item) {
      print(item.lat);
      setState(() {
        markerLocations.add(LatLng(item.lat, item.long));
        loading = false;
      });
    });
   
    addMarkers();
  }

  addMarkers() {
    for (LatLng markerLocation in markerLocations) {
      _markers.add(
        Marker(
          markerId: MarkerId(markerLocations.indexOf(markerLocation).toString()),
          position: markerLocation,
          icon: BitmapDescriptor.defaultMarker,
          onTap: () {
            print('Marker pressed');
            scaffoldKey.currentState.showBottomSheet((context) => Container(
              height: 250,
              color: Colors.red,
            ));
          }
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    getCountryCases();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps COVID19'),
      ),
      drawer: DrawerComponent(),
      backgroundColor: Colors.grey.shade200,
      body: loading ? Center(
        child: CircularProgressIndicator(),
      ): Container(
        child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: _currentPosition,
              zoom: 4.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: _markers
        ),
      ),
    );
  }
}
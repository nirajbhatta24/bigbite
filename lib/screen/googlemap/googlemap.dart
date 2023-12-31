import 'package:artsy/app/permission.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  GoogleMapController? mapController;
  Set<Marker> markers = {};
  LatLng myLocation = const LatLng(27.719374, 85.344079);

  @override
  void initState() {
    _checkUserPermission();
    markers.add(Marker(
      markerId: MarkerId(myLocation.toString()),
      position: myLocation,
      infoWindow: const InfoWindow(title: 'Artsy', snippet: 'Artsy'),
      icon: BitmapDescriptor.defaultMarker,
    ));
    super.initState();
  }

  _checkUserPermission() async {
    await UserPermission.requestLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Google Map'),
      ),
      body: GoogleMap(
        zoomGesturesEnabled: true,
        initialCameraPosition: CameraPosition(target: myLocation, zoom: 10),
        markers: markers,
        mapType: MapType.normal,
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
      ),
    );
  }
}

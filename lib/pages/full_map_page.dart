import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FullMapPage extends StatefulWidget {
  const FullMapPage({super.key});

  @override
  State<FullMapPage> createState() => _FullMapPageState();
}

class _FullMapPageState extends State<FullMapPage> {
  GoogleMapController? controller;

  LatLng? currentPosition;
  Stream<Position>? _streamPostion;

  Future<void> _initLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return;
      }
    }
    _streamPostion = Geolocator.getPositionStream();

    _streamPostion?.listen(
      (Position position) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            setState(() {
              currentPosition = LatLng(position.latitude, position.longitude);
            });
          }
        });
      },
    );

    if (controller != null) {
      controller?.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: currentPosition ?? LatLng(0, 0),
        zoom: 18,
      )));
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          currentPosition == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : GoogleMap(
                  myLocationButtonEnabled: false,
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                      zoom: 18, target: currentPosition ?? LatLng(0, 0))),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).padding.top + 10),
            child: IconButton(
                onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
          )
        ],
      ),
    );
  }
}

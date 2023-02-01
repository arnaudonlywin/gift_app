import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gift_app/helpers/color_helper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with AutomaticKeepAliveClientMixin {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Future<Position> _getUserCurrentLocation() async {
    const defaultPosition = Position(
      latitude: 45.764043,
      longitude: 4.835659,
      timestamp: null,
      accuracy: 0.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0,
    );
    try {
      final checkPermission = await Geolocator.checkPermission();
      switch (checkPermission) {
        case LocationPermission.denied:
        case LocationPermission.unableToDetermine:
          //On demande la permission
          await Geolocator.requestPermission();
          //Et on se rappelle soit même pour refaire les contrôle
          return _getUserCurrentLocation();
        case LocationPermission.deniedForever:
          //On ne peut pas redemander la permission donc on retourne
          //les coordonnés GPS de Lyon
          return defaultPosition;
        case LocationPermission.whileInUse:
        case LocationPermission.always:
          return await Geolocator.getCurrentPosition();
      }
    } catch (error) {
      //Si une erreur intervient, on retourne la position de Lyon
      return defaultPosition;
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: _getUserCurrentLocation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            !snapshot.hasError &&
            snapshot.hasData) {
          final currentPosition = snapshot.data!;
          CameraPosition cameraPosition = CameraPosition(
            target: LatLng(
              currentPosition.latitude,
              currentPosition.longitude,
            ),
            zoom: 14,
          );
          return GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: cameraPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(
            color: myPurple,
          ),
        );
      },
    );
  }
}

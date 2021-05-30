import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController {
  // ignore: cancel_subscriptions
  late StreamSubscription<Position> positionStreamSubscription;
  var currentSpeed = 0.0.obs;
  RxBool isActive = false.obs;
  late GoogleMapController mapController;

  var initialPosition = LatLng(0, 0).obs;
  List<Marker> markerList = <Marker>[];

  void getLastPosition(BuildContext context) async {
    var lastPosition = await Geolocator.getLastKnownPosition();
    setInitialPositio(LatLng(lastPosition!.latitude, lastPosition.longitude));
    showMarkPosition(lastPosition, await getPointerImage(context));
  }

  Future<Uint8List> getPointerImage(BuildContext context) async {
    Uint8List locationPointImage = await _getMarker(context);
    return locationPointImage;
  }

  Future<void> setChangeLocationStream(BuildContext context) async {
    Uint8List locationPointImage = await getPointerImage(context);

    final positionStream = Geolocator.getPositionStream(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 50);

    positionStreamSubscription = positionStream.listen((position) {
      setInitialPositio(LatLng(position!.latitude, position.longitude));
      this.currentSpeed.value = position.speed;
      showMarkPosition(position, locationPointImage);
    });
  }

  setInitialPositio(value) {
    initialPosition.value = value;
  }

  void showMarkPosition(
      Position locationToUpdate, Uint8List locationPointImage) {
    LatLng latitudelongitude = LatLng(
      locationToUpdate.latitude,
      locationToUpdate.longitude,
    );

    //Centro el mapa con la posición actual
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(latitudelongitude.latitude, latitudelongitude.longitude),
        zoom: 18.0)));

    Marker newMarker = Marker(
        markerId: MarkerId("home" + markerList.length.toString()),
        position: latitudelongitude,
        draggable: false,
        zIndex: 2,
        flat: true,
        icon: BitmapDescriptor.fromBytes(locationPointImage),
        anchor: Offset(0.5, 0.5));

    markerList.add(newMarker);
    initialPosition(
        LatLng(latitudelongitude.latitude, latitudelongitude.longitude));
  }

  startActivity() {
    isActive.value = true;
  }

  stopActivity() {
    isActive.value = false;
    currentSpeed.value = 0.0;
  }

  Future<Uint8List> _getMarker(context) async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/miaguilaMark.png");
    return byteData.buffer.asUint8List();
  }
}

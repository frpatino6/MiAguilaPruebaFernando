import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapTracking extends StatefulWidget {
  @override
  _MapTrackingState createState() => _MapTrackingState();
}

class _MapTrackingState extends State<MapTracking> {
  late LatLng _initialPosition = LatLng(0, 0);
  late StreamSubscription<Position> _positionStreamSubscription;
  late GoogleMapController mapController;
  late double currentSpeed;
  late List<Marker> markerList = <Marker>[];
  bool isActive = false;

  late Circle circle;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
        height: height,
        width: width,
        child: Scaffold(
          body: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _initialPosition,
                  zoom: 14.4746,
                ),
                myLocationEnabled: isActive,
                myLocationButtonEnabled: false,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: false,
                mapType: MapType.hybrid,
                markers: Set.of(markerList),
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                  getLastPosition();
                },
                onCameraMove: (position) {},
              ),
            ],
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                      backgroundColor: Colors.pink,
                      child: _getCurrentIcon(),
                      onPressed: () {
                        if (!isActive) {
                          _setChangeLocationStream();
                          isActive = true;
                        } else {
                          setState(() {
                            isActive = false;
                          });
                          _getCurrentIcon();
                          _positionStreamSubscription.cancel();
                        }
                      }),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: FloatingActionButton.extended(
                    onPressed: () {},
                    label: Text("${currentSpeed.round().toString()} Kms"),
                    icon: const Icon(Icons.speed),
                    backgroundColor: Colors.pink,
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Icon _getCurrentIcon() {
    if (isActive) return Icon(Icons.stop);
    return Icon(Icons.play_arrow);
  }

  @override
  void initState() {
    super.initState();
  }

  void getLastPosition() async {
    var lastPosition = await Geolocator.getLastKnownPosition();
    _initialPosition = LatLng(lastPosition!.latitude, lastPosition.longitude);
    _showMarkPosition(lastPosition, await getPointerImage());
  }

  Future<Uint8List> _getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/miaguilaMark.png");
    return byteData.buffer.asUint8List();
  }

  Future<void> _setChangeLocationStream() async {
    Uint8List locationPointImage = await getPointerImage();

    final positionStream = Geolocator.getPositionStream(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 50);

    _positionStreamSubscription = positionStream.listen((position) {
      _initialPosition = LatLng(position.latitude, position.longitude);
      this.currentSpeed = position.speed;
      _showMarkPosition(position, locationPointImage);
    });
  }

  Future<Uint8List> getPointerImage() async {
    Uint8List locationPointImage = await _getMarker();
    return locationPointImage;
  }

  void _showMarkPosition(
      Position locationToUpdate, Uint8List locationPointImage) {
    LatLng latitudelongitude = LatLng(
      locationToUpdate.latitude,
      locationToUpdate.longitude,
    );

    //Centro el mapa con la posición actual
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(latitudelongitude.latitude, latitudelongitude.longitude),
        zoom: 18.0)));
    this.setState(() {
      Marker newMarker = Marker(
          markerId: MarkerId("home" + markerList.length.toString()),
          position: latitudelongitude,
          draggable: false,
          zIndex: 2,
          flat: true,
          icon: BitmapDescriptor.fromBytes(locationPointImage),
          anchor: Offset(0.5, 0.5));

      markerList.add(newMarker);
    });
  }
}

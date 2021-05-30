import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:miaguilatraking/controller/location.dart';

// ignore: must_be_immutable
class MapTracking extends StatelessWidget {
  final locationCtrl = Get.put(LocationController());
  late Circle circle;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Obx(() => Container(
        height: height,
        width: width,
        child: Scaffold(
          body: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: locationCtrl.initialPosition.value,
                  zoom: 14.4746,
                ),
                myLocationEnabled: locationCtrl.isActive.value,
                myLocationButtonEnabled: false,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: false,
                mapType: MapType.hybrid,
                markers: Set.of(locationCtrl.markerList),
                onMapCreated: (GoogleMapController controller) {
                  locationCtrl.mapController = controller;
                  locationCtrl.getLastPosition(context);
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
                        if (!locationCtrl.isActive.isTrue) {
                          locationCtrl.setChangeLocationStream(context);
                          locationCtrl.startActivity();
                        } else {
                          locationCtrl.stopActivity();
                          _getCurrentIcon();
                          locationCtrl.positionStreamSubscription.cancel();
                        }
                      }),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: FloatingActionButton.extended(
                    onPressed: () {},
                    label: Text(
                        "${locationCtrl.currentSpeed.round().toString()} Kms"),
                    icon: const Icon(Icons.speed),
                    backgroundColor: Colors.pink,
                  ),
                ),
              ],
            ),
          ),
        )));
  }

  Icon _getCurrentIcon() {
    if (locationCtrl.isActive.isTrue) return Icon(Icons.stop);
    return Icon(Icons.play_arrow);
  }
}

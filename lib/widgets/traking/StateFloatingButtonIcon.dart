import 'package:flutter/material.dart';
import 'package:miaguilatraking/controller/location.dart';

class StateFloatingButtonIcon extends StatelessWidget {
  const StateFloatingButtonIcon({
    Key? key,
    required this.locationCtrl,
  }) : super(key: key);

  final LocationController locationCtrl;

  @override
  Widget build(BuildContext context) {
    if (locationCtrl.isActive.value) return Icon(Icons.stop);
    return Icon(Icons.play_arrow);
  }
}

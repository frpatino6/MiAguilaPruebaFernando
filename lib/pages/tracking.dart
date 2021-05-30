
import 'package:flutter/material.dart';
import 'package:miaguilatraking/widgets/traking/map-traking.dart';

//Widget que contiente la página principal
class TrackingPage extends StatelessWidget {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Traking "),
      ),
      body: _createBody(context),
    );
  }

  Widget _createBody(BuildContext context) {
    // carga el widget que contiene el mapa y realiza el proceso de geolocalización
    return MapTracking();
  }
}


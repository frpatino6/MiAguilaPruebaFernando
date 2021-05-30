import 'package:flutter/material.dart';
import 'package:miaguilatraking/widgets/traking/map-traking.dart';

class TrakingPage extends StatefulWidget {
  TrakingPage({Key? key}) : super(key: key);

  @override
  _TrakingPageState createState() => _TrakingPageState();
}

class _TrakingPageState extends State<TrakingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Traking"),
      ),
      body: _createBody(context),
    );
  }

  Widget _createBody(BuildContext context) {
    return MapTracking();
  }
}

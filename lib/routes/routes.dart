import 'package:flutter/material.dart';
import 'package:miaguilatraking/pages/traking.dart';

Map<String, WidgetBuilder> getApplicationsRoutes() {
  return <String, WidgetBuilder>{'/': (BuildContext context) => TrakingPage()};
}

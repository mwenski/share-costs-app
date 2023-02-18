import 'package:flutter/material.dart';
import 'routes.dart';

void main() {
  runApp(MaterialApp(
    title: "Share Cost App",
    initialRoute: "/new_group",
    routes: Routes.routes,
  ));
}

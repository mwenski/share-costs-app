import 'package:flutter/material.dart';
import 'routes.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    title: "Share Cost App",
    initialRoute: "/group",
    routes: Routes.routes,

  ));

}


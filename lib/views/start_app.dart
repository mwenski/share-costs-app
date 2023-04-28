import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:share_cost_app/services/authentication.dart';
import 'package:share_cost_app/views/login_view.dart';
import 'package:share_cost_app/views/group_list_view.dart';

class StartApp extends StatelessWidget {
  const StartApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        future: Future.value(Authentication.getCurrentUser()),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            return GroupListView();
          }
          return const LoginView();
        });
  }
}

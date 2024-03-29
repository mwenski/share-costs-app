import 'package:flutter/material.dart';

import 'package:share_cost_app/routes.dart';
import 'package:share_cost_app/services/authentication.dart';
import 'package:share_cost_app/components/widgets/widgets.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Share Cost App - Register")),
        body: ListView(
          padding: const EdgeInsets.all(40),
          children: [
            SingleChildScrollView(
              child: Column(children: [
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'E-mail address',
                    hintText: 'Enter your email',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter your password',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirm password',
                    hintText: 'Confirm your password',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    var response = await Authentication.userRegistration(
                        emailController.text,
                        passwordController.text,
                        confirmPasswordController.text);
                    Widgets.scaffoldMessenger(context, response, "Registered and logged in!");
                    if (response == null) {
                      Navigator.of(context).pushNamedAndRemoveUntil(Routes.group, (route) => false);
                      //Navigator.pushNamed(context, Routes.group);
                    }
                  },
                  child: const Text('Create an account!'),
                ),
              ]),
            ),
          ],
        ));
  }
}

import 'package:flutter/material.dart';

import 'package:share_cost_app/routes.dart';
import 'package:share_cost_app/services/authentication.dart';
import 'package:share_cost_app/components/widgets/widgets.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void navigateToRegister() {
      Navigator.pushNamed(context, Routes.register);
    }

    // if(Authentication.getCurrentUser() != null){
    //   Navigator.pushNamed(context, Routes.group);
    // }

    return Scaffold(
        appBar: AppBar(title: const Text("Share Cost App - Login")),
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
                    prefixIcon: Icon(Icons.people),
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
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    var response = await Authentication.signIn(emailController.text, passwordController.text);
                    Widgets.scaffoldMessenger(context, response, "Logged in!");
                    if (response == null){
                      Navigator.pushNamed(context, Routes.group);
                    }
                  },
                  child: const Text('Login!'),
                ),
                TextButton(
                    onPressed: navigateToRegister,
                    child: const Text('Create an account!'))
              ]),
            ),
          ],
        ));
  }
}

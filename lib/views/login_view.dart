import 'package:flutter/material.dart';

import 'package:share_cost_app/routes.dart';
import 'package:share_cost_app/services/authentication.dart';

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
    void _navigateToRegister() {
      Navigator.pushNamed(context, Routes.register);
    }

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
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    var res = await Authentication.signIn(emailController.text, passwordController.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            backgroundColor: res == null ? Colors.green : Colors.red,
                            content: Text(res ?? "Logged in!")));
                    if (res == null){
                      Navigator.pushNamed(context, Routes.group);
                    }
                  },
                  child: const Text('Login!'),
                ),
                TextButton(
                    onPressed: _navigateToRegister,
                    child: const Text('Create an account!'))
              ]),
            ),
          ],
        ));
  }
}

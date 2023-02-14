import 'package:flutter/material.dart';
import 'package:share_cost_app/routes.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
                const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'E-mail address',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {},
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

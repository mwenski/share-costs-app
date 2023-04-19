import 'package:flutter/material.dart';

import 'package:share_cost_app/routes.dart';
import 'package:share_cost_app/services/authentication.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: null,
            accountEmail: Text(Authentication.getCurrentUser()?.email as String),
            decoration: const BoxDecoration(color: Colors.blue),
          ),
          ListTile(
            leading: const Icon(Icons.article_outlined),
            title: const Text("Group list"),
            onTap: () => {
              Navigator.pushNamed(context, Routes.group)
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_box_outlined),
            title: const Text("Add new group"),
            onTap: () => {
            Navigator.pushNamed(context, Routes.newGroup)
            },
          ),
          const AboutListTile(
            icon: Icon(Icons.info_outline),
            applicationIcon: Icon(Icons.local_play),
            applicationName: "Share Costs App",
            applicationVersion: "0.0.1",
            applicationLegalese: "by mwenski 2023",
            child: Text("About app"),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app_outlined),
            title: const Text("Sign out"),
            onTap: () async {
              var res = await Authentication.signOut();
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      backgroundColor: res == null ? Colors.green : Colors.red,
                      content: Text(res ?? "Logged out!")));
              if(res == null){
                Navigator.of(context).pushNamedAndRemoveUntil(Routes.login, (route) => false);
              }
            },
          )
        ],
      ),
    );
  }
}

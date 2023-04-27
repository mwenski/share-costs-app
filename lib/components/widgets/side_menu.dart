import 'package:flutter/material.dart';

import 'package:share_cost_app/routes.dart';
import 'package:share_cost_app/services/authentication.dart';
import 'package:share_cost_app/components/widgets/widgets.dart';

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
            accountEmail: Text(Authentication.getCurrentUser()?.email as String ?? ""),
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
            Navigator.pushNamed(context, Routes.groupForm)
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

              var response = await Widgets.alertDialog(context, "Logging out", "Are you sure you want to log out?");
              if (response == true) {
                var result = await Authentication.signOut();
                Widgets.scaffoldMessenger(context, result, "Logged out!");
                if (result == null) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.login, (route) => false);
                }
              }
            },
          )
        ],
      ),
    );
  }
}

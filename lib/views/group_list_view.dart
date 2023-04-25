import 'package:flutter/material.dart';

import 'package:share_cost_app/routes.dart';
import 'package:share_cost_app/components/group_list/group_list.dart';
import 'package:share_cost_app/components/widgets/side_menu.dart';

class GroupListView extends StatefulWidget {
  const GroupListView({Key? key}) : super(key: key);

  @override
  State<GroupListView> createState() => _GroupListViewState();
}

class _GroupListViewState extends State<GroupListView> {
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _navigateToNewGroupView() {
      Navigator.pushNamed(context, Routes.newGroup);
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Group List View")),
      drawer: SideMenu(),
      body: GroupList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToNewGroupView,
        tooltip: "Add new group",
        child: const Icon(Icons.add),
      ),
    );
  }
}

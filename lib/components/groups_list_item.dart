import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';

import 'package:share_cost_app/services/db_operations.dart';
import 'package:share_cost_app/models/group_model.dart';
import 'package:share_cost_app/routes.dart';

class GroupsListItem extends StatelessWidget {
  const GroupsListItem(
      {super.key,
      required this.group});

  final Group group;

  @override
  Widget build(BuildContext context) {

    void _navigateToGroupView(){
      Navigator.pushNamed(context, Routes.home, arguments: group.id);
    }

    return GestureDetector(
      onTap: _navigateToGroupView,
      child: Container(
        margin: const EdgeInsets.all(2.0),
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: TextScroll(group.name,
                    style: const TextStyle(fontSize: 32, color: Colors.blue),
                    intervalSpaces: 10,
                    velocity: Velocity(pixelsPerSecond: Offset(50, 0)),
                    pauseBetween: Duration(seconds: 1),
                  ),
                )
              ],
            ),
            Text(group.ownerId,
                style: const TextStyle(fontSize: 20, color: Colors.grey)),
            // const Spacer(),
            Text(group.description,
                style: const TextStyle(fontSize: 20, color: Colors.grey)),
            Text(group.id,
                style: const TextStyle(fontSize: 20, color: Colors.grey)),
            Text(group.date.toString(),
                style: const TextStyle(fontSize: 20, color: Colors.grey)),
            Row(children: [
              TextButton(onPressed: ()=>{DbOperations.removeGroup(group.id)}, child: const Text("Remove group"))
            ],)
          ],
        ),
      ),
    );
  }
}

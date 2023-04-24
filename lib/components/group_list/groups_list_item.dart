import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';

import 'package:share_cost_app/routes.dart';
import 'package:share_cost_app/style.dart';
import 'package:share_cost_app/services/db_operations.dart';
import 'package:share_cost_app/models/group_model.dart';

class GroupsListItem extends StatelessWidget {
  const GroupsListItem(
      {super.key,
      required this.group});

  final Group group;

  @override
  Widget build(BuildContext context) {

    void _navigateToGroupView(){
      Navigator.pushNamed(context, Routes.home, arguments: group);
    }

    void removeGroup(){
      DbOperations.removeGroup(group.id);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Group deleted!"),
        backgroundColor: Colors.green,
      ));
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
                    style: Style.headerStyle,
                    intervalSpaces: 10,
                    velocity: Velocity(pixelsPerSecond: Offset(50, 0)),
                    pauseBetween: Duration(seconds: 1),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: TextScroll(group.description,
                    style: Style.subheaderStyle,
                    intervalSpaces: 10,
                    velocity: Velocity(pixelsPerSecond: Offset(50, 0)),
                    pauseBetween: Duration(seconds: 1),
                  ),
                )
              ],
            ),
            Row(children: [
              IconButton(
                onPressed: removeGroup,
                icon: Icon(Icons.delete),
                tooltip: "Remove group",
                color: Colors.blue,
                iconSize: 20,
              ),
              const Spacer(),
              Text(group.date.toString(),
                  style: Style.dateStyle),
            ],)
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:intl/intl.dart';

import 'package:share_cost_app/routes.dart';
import 'package:share_cost_app/style.dart';
import 'package:share_cost_app/services/db_operations.dart';
import 'package:share_cost_app/models/group_model.dart';
import 'package:share_cost_app/components/widgets/widgets.dart';

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

    void removeGroup() async {
      var res = await DbOperations.removeGroup(group.id);
      Widgets.scaffoldMessenger(context, res, "Group deleted!");
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
                onPressed: () async {
                  var response = await Widgets.alertDialog(
                      context, "Group removing", "Are you sure you want to remove this group?");
                  if (response == true) {
                    removeGroup();
                  }
                },
                icon: Icon(Icons.delete),
                tooltip: "Remove group",
                color: Colors.blue,
                iconSize: 20,
              ),
              const Spacer(),
              Text(DateFormat("HH:mm  dd/MM/yyyy").format(group.date),
                  style: Style.dateStyle),
            ],)
          ],
        ),
      ),
    );
  }
}

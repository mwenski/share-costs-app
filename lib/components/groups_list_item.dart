import 'package:flutter/material.dart';

import 'package:share_cost_app/models/group_model.dart';

class GroupsListItem extends StatelessWidget {
  const GroupsListItem(
      {super.key,
      required this.group});

  final Group group;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2.0),
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                group.name,
                style: const TextStyle(fontSize: 32, color: Colors.blue),
              ),
              // const Spacer()
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
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_cost_app/components/group_list/groups_list_item.dart';

import 'package:share_cost_app/style.dart';
import 'package:share_cost_app/models/group_model.dart';
import 'package:share_cost_app/services/db_operations.dart';

class GroupList extends StatefulWidget {
  const GroupList({Key? key}) : super(key: key);

  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> groupsStream = DbOperations.getGroupsStream();

    return StreamBuilder<QuerySnapshot>(
      stream: groupsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(
              child: Text(
            'Something went wrong',
            style: Style.errorStyle,
          ));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: Text(
            "Loading...",
            style: Style.loadingStyle,
          ));
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            Group group = Group.fromJson(data);
            print(group);
            return GroupsListItem(group: group);
          }).toList(),
        );
      },
    );
  }
}

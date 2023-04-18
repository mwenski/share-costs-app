import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:share_cost_app/models/group_model.dart';
import 'package:share_cost_app/models/user_model.dart';

class GroupForm extends StatefulWidget {
  const GroupForm({Key? key}) : super(key: key);

  @override
  State<GroupForm> createState() => _GroupFormState();
}

class _GroupFormState extends State<GroupForm> {
  List<TextEditingController> memberControllers = <TextEditingController>[
    TextEditingController(), TextEditingController()
  ];

  var nameController = TextEditingController();
  var descriptionController = TextEditingController();

  void _addNewMemberToList() {
    setState(() {
      memberControllers.add(TextEditingController());
    });
  }

  void _removeMemberFromList() {
    if (memberControllers.length <= 2) {
      return;
    }
    setState(() {
      memberControllers.removeLast();
    });
  }

  CollectionReference groupCollection =
      FirebaseFirestore.instance.collection('group');
  void addGroup() {
    Group group = Group(
        ownerId: "ownerId",
        name: nameController.text,
        description: descriptionController.text,
        members: memberControllers
            .map((memberController) => User(name: memberController.text))
            .toList());

    print(group.toJson());

    groupCollection
        .add(group.toJson())
        .then((value) => print("Expense Added"))
        .catchError((error) => print("Failed to add expense: $error"));

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Group created!"),
      backgroundColor: Colors.green,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Add new group")),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            SingleChildScrollView(
              child: Column(children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name Of Group',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: descriptionController,
                  keyboardType: TextInputType.multiline,
                  minLines: 5,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                    labelText: 'Description',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    Text(
                      "ADD MEMBERS TO YOUR GROUP:",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                  ],
                ),
                Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: memberControllers
                      .map((memberController) => TextFormField(
                            controller: memberController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Member Name',
                            ),
                          ))
                      .toList(),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: _addNewMemberToList,
                        child: const Text("Add member")),
                    const Spacer(),
                    TextButton(
                        onPressed: _removeMemberFromList,
                        child: const Text("Remove member"))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      addGroup();
                      Navigator.pop(context);
                    },
                    child: const Text('Create New Group!',
                        style: TextStyle(fontSize: 18)),
                  ),
                ),
              ]),
            ),
          ],
        ));
  }
}

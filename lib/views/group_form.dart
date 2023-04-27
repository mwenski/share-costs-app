import 'package:flutter/material.dart';

import 'package:share_cost_app/constant.dart';
import 'package:share_cost_app/style.dart';
import 'package:share_cost_app/models/group_model.dart';
import 'package:share_cost_app/models/user_model.dart';
import 'package:share_cost_app/services/authentication.dart';
import 'package:share_cost_app/services/db_operations.dart';
import 'package:share_cost_app/components/widgets/widgets.dart';

class GroupForm extends StatefulWidget {
  const GroupForm({Key? key}) : super(key: key);

  @override
  State<GroupForm> createState() => _GroupFormState();
}

class _GroupFormState extends State<GroupForm> {
  List<TextEditingController> memberControllers = <TextEditingController>[];

  bool flag = true;

  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  String? groupId;

  void _addNewMemberToList() {
    print("object");
    setState(() {
      memberControllers.add(TextEditingController());
    });
  }

  void _removeLastMemberFromList() {
    if (memberControllers.length <= 2) {
      Widgets.scaffoldMessenger(
          context, "Group cannot have less than 2 members!", "");
      return;
    }
    setState(() {
      memberControllers.removeLast();
    });
  }

  void _removeMemberFromList(TextEditingController memberController) {
    if (memberControllers.length <= 2) {
      Widgets.scaffoldMessenger(
          context, "Group cannot have less than 2 members!", "");
      return;
    }
    setState(() {
      memberControllers.remove(memberController);
    });
  }

  void addGroup() {
    Group newGroup = Group(
        ownerId: Authentication.getCurrentUser()?.uid as String,
        name: nameController.text,
        description: descriptionController.text,
        members: memberControllers
            .map((memberController) => User(name: memberController.text))
            .toList());

    var response = DbOperations.addGroup(newGroup);
    Widgets.scaffoldMessenger(context, response, "Group created!");
  }

  void updateGroup() async {
    Group updatedGroup = Group(
        id: groupId,
        ownerId: Authentication.getCurrentUser()?.uid as String,
        name: nameController.text,
        description: descriptionController.text,
        members: memberControllers
            .map((memberController) => User(name: memberController.text))
            .toList());

    var response = await DbOperations.updateGroup(updatedGroup);
    Widgets.scaffoldMessenger(context, response, "Group updated!");
  }

  @override
  Widget build(BuildContext context) {

    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final FormType formType = arguments["formType"];

    Group group;

    if (formType == FormType.update && flag) {
      group = arguments["group"];
      groupId = group.id;
      nameController = TextEditingController(text: group.name);
      descriptionController = TextEditingController(text: group.description);
      group.members.forEach((element) {
        memberControllers.add(TextEditingController(text: element.name));
      });
    }else if(flag){
      memberControllers = <TextEditingController>[
        TextEditingController(),
        TextEditingController()
      ];
    }

    flag = false;

    return Scaffold(
        appBar: AppBar(title: Text(formType==FormType.update? "Update group" : "Add new group")),
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
                  children: [
                    Text(
                      formType == FormType.update? "Update members:" : "Add members:",
                      style: Style.subheaderStyle,
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: memberControllers
                      .map((memberController) => Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: memberController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Member Name',
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                _removeMemberFromList(memberController);
                              },
                              icon: Icon(Icons.close),
                              tooltip: "Remove member",
                              color: Colors.red,
                              iconSize: 20),
                        ],
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
                        onPressed: _removeLastMemberFromList,
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
                    onPressed: () async {
                      formType == FormType.update? await {updateGroup()} : {addGroup()};
                      Navigator.pop(context);
                    },
                    child: Text(formType==FormType.update? "Update group" : "Create new group",
                        style: const TextStyle(fontSize: 18)),
                  ),
                ),
              ]),
            ),
          ],
        ));
  }
}

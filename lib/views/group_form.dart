import 'package:flutter/material.dart';

import 'package:share_cost_app/constant.dart';
import 'package:share_cost_app/style.dart';
import 'package:share_cost_app/models/group_model.dart';
import 'package:share_cost_app/models/user_model.dart';
import 'package:share_cost_app/services/authentication.dart';
import 'package:share_cost_app/services/db_operations.dart';
import 'package:share_cost_app/components/widgets/widgets.dart';
import 'package:share_cost_app/components/widgets/side_menu.dart';

class GroupForm extends StatefulWidget {
  const GroupForm({Key? key}) : super(key: key);

  @override
  State<GroupForm> createState() => _GroupFormState();
}

class _GroupFormState extends State<GroupForm> {
  List<TextEditingController> memberControllers = <TextEditingController>[];
  Map<TextEditingController, String> memberIds = {};

  String? groupId;
  FormType? formType;
  bool flag = true;

  var nameController = TextEditingController();
  var descriptionController = TextEditingController();

  void _addNewMemberToList() {
    setState(() {
      memberControllers.add(TextEditingController());
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
      if(memberIds.containsKey(memberController)){
        memberIds.remove(memberController);
      }
    });
  }

  String? addGroup() {
    var response;
    Group newGroup = Group(
        ownerId: Authentication.getCurrentUser()?.uid as String,
        name: nameController.text,
        description: descriptionController.text,
        members: memberControllers
            .map((memberController) => User(name: memberController.text))
            .toList());

    response = DbOperations.addGroup(newGroup);
    return response;
  }

  Future<String?> updateGroup() async {
    var response;
    Group updatedGroup = Group(
        id: groupId,
        ownerId: Authentication.getCurrentUser()?.uid as String,
        name: nameController.text,
        description: descriptionController.text,
        members: memberControllers
            .map((memberController) => User(
                id: memberIds[memberController], name: memberController.text))
            .toList());

    response = await DbOperations.updateGroup(updatedGroup);
    return response;
  }

  void performOperation() async {
    var response;
    if(formType == FormType.update){
      response = await updateGroup();
    }else{
      response = addGroup();
    }
    Widgets.scaffoldMessenger(context, response, formType==FormType.update ? "Group updated!" : "Group created!");
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    formType = arguments["formType"];

    Group group;

    if (formType == FormType.update && flag) {
      group = arguments["group"];
      groupId = group.id;
      nameController = TextEditingController(text: group.name);
      descriptionController = TextEditingController(text: group.description);
      group.members.forEach((element) {
        var memberController = TextEditingController(text: element.name);
        memberControllers.add(memberController);
        memberIds[memberController] = element.id;
      });
    } else if (flag) {
      memberControllers = <TextEditingController>[
        TextEditingController(),
        TextEditingController()
      ];
    }

    flag = false;

    return Scaffold(
        appBar: AppBar(
            title: Text(formType == FormType.update
                ? "Update group"
                : "Add new group")),
        endDrawer: const SideMenu(),
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
                      formType == FormType.update
                          ? "Update members:"
                          : "Add members:",
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
                                  icon: const Icon(Icons.close),
                                  tooltip: "Remove member",
                                  color: Colors.red,
                                  iconSize: 30),
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
                      performOperation();
                      Navigator.pop(context);
                    },
                    child: Text(
                        formType == FormType.update
                            ? "Update group"
                            : "Create new group",
                        style: const TextStyle(fontSize: 18)),
                  ),
                ),
              ]),
            ),
          ],
        ));
  }
}

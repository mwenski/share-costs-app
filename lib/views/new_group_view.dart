import 'package:flutter/material.dart';

class NewGroupView extends StatefulWidget {
  const NewGroupView({Key? key}) : super(key: key);

  @override
  State<NewGroupView> createState() => _NewGroupViewState();
}

class _NewGroupViewState extends State<NewGroupView> {
  int _numberOfMembers = 0;

  void _increaseNumberOfMembers() {
    setState(() {
      _numberOfMembers++;
    });
  }

  void _decreaseNumberOfMembers() {
    setState(() {
      if (_numberOfMembers > 0) _numberOfMembers--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Share Cost App - Add new group")),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            SingleChildScrollView(
              child: Column(children: [
                const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name Of Group',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const TextField(
                  keyboardType: TextInputType.multiline,
                  minLines: 5,
                  maxLines: 5,
                  decoration: InputDecoration(
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
                      style: TextStyle(fontSize: 16, color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                  ],
                ),
                for (int i = 0; i <= _numberOfMembers; i++)
                  Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Member Name #$i',
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: _increaseNumberOfMembers,
                        child: const Text("Add member")),
                    const Spacer(),
                    TextButton(
                        onPressed: _decreaseNumberOfMembers,
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
                    onPressed: () {},
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

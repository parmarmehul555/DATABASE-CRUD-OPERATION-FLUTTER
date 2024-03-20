import 'package:crud_evaluation/my_database.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  Map<String, dynamic>? map;

  AddUser(this.map);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text =
        widget.map == null ? '' : widget.map!['name'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add User"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                controller: nameController,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  widget.map == null
                      ? insetUser().then(
                          (value) {
                            Navigator.of(context).pop(true);
                          },
                        ).then(
                          (value) {
                            setState(() {});
                          },
                        )
                      : updateUser().then(
                          (value) {
                            Navigator.of(context).pop(true);
                          },
                        ).then(
                          (value) {
                            setState(() {});
                          },
                        );
                },
                child: Text("Submit")),
          ],
        ));
  }

  Future<int> insetUser() async {
    Map<String, dynamic> map = Map();
    map['name'] = nameController.text;
    int res = await MyDatabase().addUser(map);
    return res;
  }

  Future<int> updateUser() async {
    Map<String, dynamic> map = Map();
    map['name'] = nameController.text;
    int res = await MyDatabase().editUser(map, widget.map!['id']);
    return res;
  }
}

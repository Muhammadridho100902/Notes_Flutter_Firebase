// ignore_for_file: prefer_const_constructors, file_names, prefer_typing_uninitialized_variables, unused_local_variable, await_only_futures, no_logic_in_create_state

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_3/model/usermodel.dart';
import 'package:project_3/service/auth_service.dart';
import 'package:project_3/view/seenote.dart';

class UpdatePage extends StatefulWidget {
  final String titleValue, notesValue;


  const UpdatePage({Key? key, required this.titleValue, required this.notesValue}) : super(key: key);

  @override
  State<UpdatePage> createState() {
    return _UpdatePageState(titleValue, notesValue);
  }
}

class _UpdatePageState extends State<UpdatePage> {
  late DateTime _myStartDate;
  String starttime = '';
  TextEditingController title = TextEditingController();
  TextEditingController notes = TextEditingController();

  // var notes;

  var g;

  var k;

  var o;

  final fb = FirebaseDatabase.instance;
  final AuthService _authService = AuthService();

  UserModel? _userFromFirebase(User user) {
    return UserModel(
      userId: user.uid,
      name: user.displayName,
      email: user.email,
    );
  }

  final String titleValue, notesValue;
  _UpdatePageState(this.titleValue, this.notesValue);

  @override
  Widget build(BuildContext context) {
    final myUserId = FirebaseAuth.instance.currentUser?.uid;

    var rng = Random();
    var k = rng.nextInt(10000);
    final ref = fb.ref().child('todos/$k');

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 15, right: 15),
              child: TextField(
                controller: title,
                decoration: InputDecoration(
                    hintText: titleValue ,
                    // labelText: "Title",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
              child: SizedBox(
                height: 350,
                child: TextField(
                  controller: notes,
                  maxLines: 50,
                  // maxLength: 100,
                  decoration: InputDecoration(
                      // labelText: "Notes",
                      hintText: notesValue,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 140,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        width: 2,
                        color: Colors.grey,
                        style: BorderStyle.solid)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Date"),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      starttime,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 5, 25, 0),
                      child: ElevatedButton(
                        onPressed: () async {
                          _myStartDate = (await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2015),
                            lastDate: DateTime(2025),
                          ))!;
                          setState(() {
                            starttime =
                                DateFormat('dd-MM-yyyy').format(_myStartDate);
                          });
                        },
                        child: Text("Choose the date"),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                // final ref = fb.ref().child('todos/$k');
                DatabaseReference refUpd =
                    FirebaseDatabase.instance.ref("todos/$k");

                // only update the name
                await refUpd.update(
                  {
                    "userId_": k.toString(),
                    "title_": title.text,
                    "notes_": notes.text,
                    "date_": starttime.toString()
                  },
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SeeNotes(),
                  ),
                );
              },
              child: Container(
                width: 250,
                height: 50,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 217, 67, 200),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 2,
                        offset: Offset(2, 2),
                        spreadRadius: 2)
                  ],
                ),
                child: Center(
                  child: Text(
                    "Save",
                    style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  upd() async {
    // DatabaseReference ref = FirebaseDatabase.instance.ref("todos/$k");
    final ref = fb.ref().child('todos/$k');

    // only update the name
    await ref.update(
      {
        "title_": title.text,
        "notes_": notes.text,
        "date_": starttime.toString()
      },
    );

    title.clear();
    notes.clear();
  }
}

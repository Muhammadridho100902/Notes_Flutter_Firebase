// ignore_for_file: prefer_const_constructors, file_names, prefer_typing_uninitialized_variables, unused_local_variable, await_only_futures, no_logic_in_create_state, unused_field
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UpdatePage extends StatefulWidget {
  final String idValue, titleValue, notesValue, dateValue;
  // final DateTime dateValue;

  const UpdatePage(
      {Key? key,required this.idValue ,required this.titleValue, required this.notesValue, required this.dateValue})
      : super(key: key);

  @override
  State<UpdatePage> createState() {
    return _UpdatePageState(idValue, titleValue, notesValue, dateValue);
  }
}

class _UpdatePageState extends State<UpdatePage> {
  late DateTime _myStartDate;
  String starttime = '';

  TextEditingController title = TextEditingController();
  TextEditingController notes = TextEditingController();

  var g;

  var k;

  var o;

  final fb = FirebaseDatabase.instance;

  final String idValue, titleValue, notesValue, dateValue;
  // final DateTime dateValue;
  _UpdatePageState(this.idValue,this.titleValue, this.notesValue, this.dateValue);

  @override
  void initState() {
    super.initState();
    title.text = titleValue;
    notes.text = notesValue;
    k = idValue;
  }

  @override
  Widget build(BuildContext context) {
    final myUserId = FirebaseAuth.instance.currentUser?.uid;

    var rng = Random();
    var k = rng.nextInt(10000);
    final ref = fb.ref().child('/todos/$k');

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 15, right: 15),
              child: TextField(
                controller: title,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
              child: SizedBox(
                height: 450,
                child: TextField(
                  controller: notes,
                  maxLines: 50,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                await upd();
                Navigator.of(context).pop();
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
                    "Update",
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
    DatabaseReference ref = FirebaseDatabase.instance.ref("todos/$k");

    // only update the name
    await ref.update(
      {
        "userId_": k.toString(),
        "title_": title.text,
        "notes_": notes.text
      },
    );

    title.clear();
    notes.clear();
    starttime = '';
  }
}

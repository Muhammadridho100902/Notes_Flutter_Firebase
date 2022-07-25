// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_3/model/usermodel.dart';
import 'package:project_3/view/seenote.dart';

class UpdatePage extends StatefulWidget {
  // final String titleValue, noteValue;
  // final UserModel NotesValue;

  const UpdatePage({Key? key}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  late DateTime _myStartDate;
  String starttime = '';
  TextEditingController title = TextEditingController();
  TextEditingController notes = TextEditingController();

  final fb = FirebaseDatabase.instance;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   title =
  // }

  @override
  Widget build(BuildContext context) {
    var rng = Random();
    var k = rng.nextInt(10000);
    final ref = fb.ref().child('todos/$k');
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: title,
              decoration: InputDecoration(
                  hintText: "Title",
                  // labelText: "${}",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: notes,
              decoration: InputDecoration(
                  hintText: "Title",
                  // labelText: "${notes}",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            height: 160,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    width: 2, color: Colors.grey, style: BorderStyle.solid)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Start Date"),
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
                            DateFormat('dd-mm-yyyy').format(_myStartDate);
                      });
                    },
                    child: Text("Choose the date"),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              ref.set(
                {
                  "userId_": k.toString(),
                  "title_": title.text,
                  "notes_": notes.text,
                  "date_": starttime.toString()
                },
              ).asStream();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SeeNotes(),
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
    );
  }
}

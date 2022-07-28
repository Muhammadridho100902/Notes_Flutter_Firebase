// ignore_for_file: prefer_const_constructors, unused_field, unused_element

import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_3/service/auth_service.dart';
import 'package:project_3/view/seenote.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  late DateTime _myStartDate;
  String starttime = '';
  TextEditingController title = TextEditingController();
  TextEditingController notes = TextEditingController();

  final fb = FirebaseDatabase.instance;
  final AuthService _authService = AuthService();


  @override
  Widget build(BuildContext context) {
    // final myUserId = FirebaseAuth.instance.currentUser?.uid;

    var rng = Random();
    var k = rng.nextInt(10000);
    final ref = fb.ref().child('todos/$k');
    // final ref = fb.ref().child('users/$myUserId/notes/$k');

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
                    hintText: "Title",
                    // labelText: "Title",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 15, right: 15),
              child: SizedBox(
                height: 350,
                child: TextField(
                  controller: notes,
                  maxLines: 50,
                  // maxLength: 100,
                  decoration: InputDecoration(
                      // labelText: "Notes",
                      hintText: "Notes",
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
                        width: 2, color: Colors.grey, style: BorderStyle.solid)),
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
              onTap: () {
                // addNote();
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
}

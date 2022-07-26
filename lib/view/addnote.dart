// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_3/model/usermodel.dart';
import 'package:project_3/service/auth_service.dart';
import 'package:project_3/view/seenote.dart';

class Notes extends StatefulWidget {
  final UserModel ?user;
  const Notes({Key? key, this.user}) : super(key: key);

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

  // UserModel? _userFromFirebase(User user) {
  //   return UserModel(userId: user.uid, name: user.displayName,email: user.email,);
  // }

  @override
  Widget build(BuildContext context) {
    // final user = UserModel();

    var rng = Random();
    var k = rng.nextInt(10000);
    final ref = fb.ref().child('users/${widget.user?.userId}/notes/$k');
    // final ref = fb.ref().child('users/$UserModel.userId/notes/$k');

    // void addNote() {
    //   ref.set(
    //     {
    //       "userId_": k.toString(),
    //       "title_": title.text,
    //       "notes_": notes.text,
    //       "date_": starttime.toString()
    //     },
    //   ).asStream();
    //   if (user != null) {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => SeeNotes(user: user),
    //       ),
    //     );
    //   }
    // }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: title,
              decoration: InputDecoration(
                  // hintText: "Title",
                  labelText: "Title",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: notes,
              decoration: InputDecoration(
                  // hintText: "Title",
                  labelText: "Notes",
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
                  // builder: (_) => Center(child: Text("berhasil add"),)
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
    );
  }
}

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field, prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_print, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:project_3/service/auth_service.dart';
import 'package:project_3/view/addnote.dart';
import 'package:project_3/view/updatePage.dart';
import '../view/updatePage.dart';

class SeeNotes extends StatefulWidget {
  // final String titleValue, notesValue;
  const SeeNotes({Key? key}) : super(key: key);
  // const SeeNotes({Key? key, required this.titleValue, required this.notesValue})
  //     : super(key: key);

  @override
  State<SeeNotes> createState() => _SeeNotesState();

  // @override
  // State<SeeNotes> createState() {
  //   return _SeeNotesState(titleValue, notesValue);
  // }
}

class _SeeNotesState extends State<SeeNotes> {
  final AuthService _authService = AuthService();

  final fb = FirebaseDatabase.instance;

  late DateTime _myStartDate;
  String starttime = '';
  TextEditingController title = TextEditingController();
  TextEditingController notesV = TextEditingController();

  var notes;

  var g;

  var k;

  var o;

  @override
  Widget build(BuildContext context) {
    final myUserid = FirebaseAuth.instance.currentUser?.uid;
    // final ref = fb.ref().child('users/$myUserid/notes');
    final ref = fb.ref().child('todos');

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 70, right: 20),
                        child: Text(
                          "Hi, Welcome",
                          style: TextStyle(
                              fontSize: 30,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Notes()));
                        },
                        icon: Icon(Icons.add),
                        color: Colors.white,
                        iconSize: 36,
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                                title: Text(
                                  "Do You Want to Log Out?",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                actions: <Widget>[
                                  MaterialButton(
                                    onPressed: () {
                                      cancel();
                                    },
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    child: Text("Cancel"),
                                  ),
                                  MaterialButton(
                                    onPressed: () async {
                                      await _authService.signout();
                                      Navigator.of(ctx).pop();
                                    },
                                    color: Colors.red,
                                    textColor: Colors.white,
                                    child: Text("Log out"),
                                  )
                                ]),
                          );
                        },
                        icon: Icon(Icons.person),
                        color: Colors.white,
                        iconSize: 36,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                FirebaseAnimatedList(
                  shrinkWrap: true,
                  query: ref,
                  itemBuilder: (context, snapshot, animation, index) {
                    var v = snapshot.value.toString();
                    g = v.replaceAll(
                        RegExp("{|}userId_: |title_: |notes_: |date_: "), "");
                    g.trim();
                    notes = g.split(',');
                    if (snapshot.exists) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            k = snapshot.key;
                          });

                          // print('${notes[1]}');

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdatePage(
                                idValue: k.toString(),
                                titleValue: '${notes[1]}',
                                notesValue: '${notes[2]}',
                                dateValue: '${notes[3]}',
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  stops: [0.1, 1],
                                  colors: <Color>[
                                    Color(0xFFffffff).withOpacity(0.45),
                                    Color(0xFFFFFFFF).withOpacity(0.2),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20)),
                            child: ListTile(
                              trailing: IconButton(
                                onPressed: () {
                                  ref.child(snapshot.key!).remove();
                                  // Delete();
                                },
                                icon: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 40,
                                  ),
                                ),
                              ),
                              title: Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, top: 15),
                                child: Text(
                                  notes[1],
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              subtitle: Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, top: 5),
                                child: Text(
                                  notes[2],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: Text("Data doesn't exist"),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void cancel() {
    Navigator.pop(context);

    title.clear();
    notesV.clear();
    starttime = "";
  }

  upd() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("todos/$k");
    await ref.update(
      {
        "title_": title.text,
        "notes_": notesV.text,
        "date_": starttime.toString()
      },
    );

    title.clear();
    notesV.clear();
    // starttime = '';
  }
}

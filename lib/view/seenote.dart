// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field, prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_print, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:project_3/service/auth_service.dart';
import 'package:project_3/view/addnote.dart';
import 'package:project_3/view/updatePage.dart';
import '../view/updatePage.dart';

class SeeNotes extends StatefulWidget {
  // final UserModel? user;
  const SeeNotes({Key? key}) : super(key: key);
  // const SeeNotes({Key? key}) : super(key: key);

  @override
  State<SeeNotes> createState() => _SeeNotesState();
}

class _SeeNotesState extends State<SeeNotes> {
  final AuthService _authService = AuthService();

  final fb = FirebaseDatabase.instance;

  late DateTime _myStartDate;
  String starttime = '';
  late DateTime _myEndDate;
  String endtime = '';
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
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 20),
                  //   child: GestureDetector(
                  //     onTap: () async {
                  //       await _authService.signout();
                  //     },
                  //     child: Container(
                  //       width: 70,
                  //       height: 30,
                  //       decoration: BoxDecoration(
                  //           color: Color.fromARGB(255, 255, 255, 255),
                  //           boxShadow: [
                  //             BoxShadow(
                  //                 color: Colors.grey.shade200,
                  //                 blurRadius: 2,
                  //                 offset: Offset(2, 2),
                  //                 spreadRadius: 5)
                  //           ],
                  //           borderRadius: BorderRadius.circular(15)),
                  //       child: Center(
                  //         child: Text(
                  //           "Log Out",
                  //           style: TextStyle(
                  //               fontSize: 16, fontWeight: FontWeight.bold),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // )
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

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdatePage(
                                      titleValue: '${notes[1]}',
                                      notesValue: '${notes[2]}',
                                    )),
                          );

                          // print("Title: ${notes[1]} ||Note: ${notes[2]}",);

                          // showDialog(
                          //   context: context,
                          //   builder: (ctx) => AlertDialog(
                          //     title: Column(
                          //       children: [
                          //         Container(
                          //           width: 500,
                          //           decoration:
                          //               BoxDecoration(border: Border.all()),
                          //           child: TextField(
                          //             controller: title,
                          //             textAlign: TextAlign.center,
                          //             decoration:
                          //                 InputDecoration(hintText: "Title"),
                          //           ),
                          //         ),
                          //         SizedBox(
                          //           height: 10,
                          //         ),
                          //         Container(
                          //           width: 500,
                          //           height: 100,
                          //           decoration:
                          //               BoxDecoration(border: Border.all()),
                          //           child: TextField(
                          //             maxLengthEnforcement:
                          //                 MaxLengthEnforcement.enforced,
                          //             maxLines: 20,
                          //             controller: notesV,
                          //             textAlign: TextAlign.center,
                          //             decoration:
                          //                 InputDecoration(hintText: "Notes"),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //     content: Container(
                          //       width: MediaQuery.of(context).size.width / 2,
                          //       height: 160,
                          //       decoration: BoxDecoration(
                          //           color: Colors.white,
                          //           borderRadius: BorderRadius.circular(20),
                          //           border: Border.all(
                          //               width: 2,
                          //               color: Colors.grey,
                          //               style: BorderStyle.solid)),
                          //       child: Column(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: [
                          //           Text("Start Date"),
                          //           SizedBox(
                          //             height: 10,
                          //           ),
                          //           Text(
                          //             starttime,
                          //             style: TextStyle(
                          //               color: Colors.black,
                          //               fontSize: 24,
                          //             ),
                          //           ),
                          //           SizedBox(
                          //             height: 10,
                          //           ),
                          //           Padding(
                          //             padding: const EdgeInsets.fromLTRB(
                          //                 25, 5, 25, 0),
                          //             child: ElevatedButton(
                          //               onPressed: () async {
                          //                 _myStartDate = (await showDatePicker(
                          //                   context: context,
                          //                   initialDate: DateTime.now(),
                          //                   firstDate: DateTime(2015),
                          //                   lastDate: DateTime(2025),
                          //                 ))!;
                          //                 setState(() {
                          //                   starttime = DateFormat('dd-MM-yyyy')
                          //                       .format(_myStartDate);
                          //                 });
                          //               },
                          //               child: Text("Choose the date"),
                          //             ),
                          //           )
                          //         ],
                          //       ),
                          //     ),
                          //     actions: <Widget>[
                          //       MaterialButton(
                          //         onPressed: () {
                          //           cancel();
                          //         },
                          //         color: Colors.red,
                          //         child: Text("Cancel"),
                          //       ),
                          //       MaterialButton(
                          //         onPressed: () async {
                          //           await upd();
                          //           Navigator.of(ctx).pop();
                          //         },
                          //         color: Colors.red,
                          //         child: Text("Update"),
                          //       )
                          //     ],
                          //   ),
                          // );
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
                                // color: Colors.blue,
                                // boxShadow: [
                                //   BoxShadow(
                                //       offset: Offset(2, 2),
                                //       blurRadius: 5,
                                //       color: Colors.grey,
                                //       spreadRadius: 3)
                                // ],
                                borderRadius: BorderRadius.circular(20)),
                            child: ListTile(
                              // shape: RoundedRectangleBorder(
                              //   side: BorderSide(color: Colors.white),
                              //   borderRadius: BorderRadius.circular(15),
                              // ),
                              // tileColor: Color.fromARGB(255, 192, 192, 192),
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
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (_) => Notes(),
      //       ),
      //     );
      //   },
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }

  void cancel() {
    Navigator.pop(context);

    title.clear();
    notesV.clear();
    starttime = "";
  }

  // Delete() {
  //   DatabaseReference ref = FirebaseDatabase.instance.ref('todos/$k');

  //   ref.remove();
  // }

  upd() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("todos/$k");

    // only update the name
    await ref.update(
      {
        "title_": title.text,
        "notes_": notesV.text,
        "date_": starttime.toString()
      },
    );

    title.clear();
    notes.clear();
    starttime = '';
  }
}

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:project_3/Routes/route.dart';
import 'package:project_3/model/usermodel.dart';
import 'package:project_3/service/auth_service.dart';
import 'package:project_3/view/addnote.dart';
import 'package:project_3/view/updatePage.dart';

class SeeNotes extends StatefulWidget {
  final UserModel ?user;
  const SeeNotes({Key? key, this.user}) : super(key: key);
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
  TextEditingController notes = TextEditingController();

  var l;

  var g;

  var k;

  var o;

  @override
  Widget build(BuildContext context) {
    // final ref = fb.ref().child('todos');
    // final ref = fb.ref().child('users/zyCJ0fmy8xhVy8ZlIv0hofD9th92/notes');
    final ref = fb.ref().child('users/${widget.user?.userId}/notes');

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 70, right: 20),
                      child: Text(
                        "Hi, Welcome",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 70, right: 20),
                    //   child: Text(
                    //     "${widget.user.userId}",
                    //     style: TextStyle(
                    //         fontSize: 30,
                    //         color: Colors.black,
                    //         fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                  ],
                ),
                // ElevatedButton(onPressed: (){}, child: Text("Log Out"))
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    onTap: () async {
                      await _authService.signout();
                    },
                    child: Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 2,
                                offset: Offset(2, 2),
                                spreadRadius: 5)
                          ],
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text(
                          "Log Out",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 5, left: 20),
            //   child: Text(
            //     "Muhammad Ridho",
            //     style: TextStyle(
            //         fontSize: 26,
            //         color: Colors.black,
            //         fontWeight: FontWeight.w400),
            //   ),
            // ),
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
                    l = g.split(',');

                    if (snapshot.exists) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            k = snapshot.key;
                          });

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdatePage()));

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
                          //             controller: notes,
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
                          //                   starttime = DateFormat('dd-mm-yyyy')
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
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              tileColor: Color.fromARGB(255, 192, 192, 192),
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
                                    const EdgeInsets.only(right: 10, top: 20),
                                child: Text(
                                  l[1],
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text(
                                  l[2],
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Notes(),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }

  void cancel() {
    Navigator.pop(context);

    title.clear();
    notes.clear();
    starttime = "";
  }

  Delete() {
    DatabaseReference ref = FirebaseDatabase.instance.ref('todos/$k');

    ref.remove();
  }

  upd() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("todos/$k");

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

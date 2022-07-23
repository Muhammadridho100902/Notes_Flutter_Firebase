// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_3/service/auth_service.dart';
import 'package:project_3/view/addnote.dart';

class SeeNotes extends StatefulWidget {
  const SeeNotes({Key? key}) : super(key: key);

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

  // final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    // var rng = Random();
    // var o = rng.nextInt(10000);
    // final ref = fb.ref().child('todos/$k');

    // final databaseRef = FirebaseDatabase.instance.ref().child("todos");

    final ref = fb.ref().child('todos/$k');

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
                    g = v.replaceAll(RegExp("{|}userId_: |title_: |notes_: |date_: "), "");
                    g.trim();
                    l = g.split(',');

                    if (snapshot.exists) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            k = snapshot.key;
                          });

                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Container(
                                width: 200,
                                decoration: BoxDecoration(border: Border.all()),
                                child: TextField(
                                  controller: title,
                                  textAlign: TextAlign.center,
                                  decoration:
                                      InputDecoration(hintText: "Title"),
                                ),
                              ),
                              content: Container(
                                width: 500,
                                height: 100,
                                decoration: BoxDecoration(border: Border.all()),
                                child: TextField(
                                  maxLengthEnforcement:
                                      MaxLengthEnforcement.enforced,
                                  maxLines: 20,
                                  controller: notes,
                                  textAlign: TextAlign.center,
                                  decoration:
                                      InputDecoration(hintText: "Notes"),
                                ),
                              ),
                              actions: <Widget>[
                                MaterialButton(
                                  onPressed: () {
                                    cancel();
                                  },
                                  color: Colors.red,
                                  child: Text("Cancel"),
                                ),
                                MaterialButton(
                                  onPressed: () async {
                                    await upd();
                                    Navigator.of(ctx).pop();
                                  },
                                  color: Colors.red,
                                  child: Text("Update"),
                                )
                              ],
                            ),
                          );
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: ListTile(
                              // leading: Padding(
                              //   padding: const EdgeInsets.only(top: 13, left: 10),
                              //   child: Icon(
                              //     Icons.timer,
                              //     size: 40,
                              //     color: Colors.white,
                              //   ),
                              // ),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              tileColor: Color.fromARGB(255, 192, 192, 192),
                              trailing: IconButton(
                                onPressed: () {
                                // ref.child(snapshot.key!).remove();
                                Delete();
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
                              title: Column(
                                children: [
                                  Padding(
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
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(right: 10),
                                    child: Text(
                                      l[2],
                                      style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: Text(
                                  l[0],
                                  style: TextStyle(
                                    fontSize: 16,
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

                    // return GestureDetector(
                    //   onTap: () {
                    //     setState(() {
                    //       k = snapshot.key;
                    //     });

                    //     showDialog(
                    //       context: context,
                    //       builder: (ctx) => AlertDialog(
                    //         title: Container(
                    //           decoration: BoxDecoration(border: Border.all()),
                    //           child: TextField(
                    //             controller: title,
                    //             textAlign: TextAlign.center,
                    //             decoration: InputDecoration(hintText: "Title"),
                    //           ),
                    //         ),
                    //         content: Container(
                    //           decoration: BoxDecoration(border: Border.all()),
                    //           child: TextField(
                    //             controller: notes,
                    //             textAlign: TextAlign.center,
                    //             decoration:
                    //                 InputDecoration(hintText: "Notes"),
                    //           ),
                    //         ),
                    //         actions: <Widget>[
                    //           MaterialButton(
                    //             onPressed: () {
                    //               Navigator.of(ctx).pop();
                    //             },
                    //             color: Colors.red,
                    //             child: Text("Cancel"),
                    //           ),
                    //           MaterialButton(
                    //             onPressed: () async {
                    //               await upd();
                    //               Navigator.of(ctx).pop();
                    //             },
                    //             color: Colors.red,
                    //             child: Text("Update"),
                    //           )
                    //         ],
                    //       ),
                    //     );
                    //   },
                    //   child: SizedBox(
                    //     width: MediaQuery.of(context).size.width,
                    //     height: 150,
                    //     child: Padding(
                    //       padding: EdgeInsets.all(20),
                    //       child: ListTile(
                    //         shape: RoundedRectangleBorder(
                    //           side: BorderSide(color: Colors.white),
                    //           borderRadius: BorderRadius.circular(15),
                    //         ),
                    //         tileColor: Color.fromARGB(255, 216, 129, 206),
                    //         trailing: IconButton(
                    //           onPressed: () {
                    //             ref.child(snapshot.key!).remove();
                    //           },
                    //           icon: Padding(
                    //             padding: const EdgeInsets.only(top: 8),
                    //             child: Icon(
                    //               Icons.delete,
                    //               color: Colors.red,
                    //               size: 40,
                    //             ),
                    //           ),
                    //         ),
                    //         title: Padding(
                    //           padding:
                    //               const EdgeInsets.only(right: 10, top: 20),
                    //           child: Text(
                    //             l[3],
                    //             style: TextStyle(
                    //               fontSize: 26,
                    //               fontWeight: FontWeight.bold,
                    //             ),
                    //           ),
                    //         ),
                    //         subtitle: Padding(
                    //           padding: const EdgeInsets.only(left: 6),
                    //           child: Text(
                    //             l[1],
                    //             style: TextStyle(
                    //               fontSize: 16,
                    //               fontWeight: FontWeight.bold,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // );
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
  }

  // void UpdateUser() async{
  //   FirebaseDatabase database = FirebaseDatabase.instance;
  //   DatabaseReference ref = database.ref().child('todos');

  //   await ref.child('todos').update({
  //     "title": title.text,
  //     "notes": notes.text
  //   }). then((value) => print("Transaction Commited"));

  //   title.clear();
  //   notes.clear();
  // }

  Delete() async{
    DatabaseReference ref = FirebaseDatabase.instance.ref('todos/$k');

    await ref.remove();
  }

  upd() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("todos/$k");

    // only update the name
    await ref.update(
      {"title_": title.text, "notes_": notes.text, "date_": starttime.toString()},
    );

    title.clear();
    notes.clear();
  }
}

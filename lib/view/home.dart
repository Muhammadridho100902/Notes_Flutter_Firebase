// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project_3/view/addnote.dart';
import 'package:project_3/view/seenote.dart';

class Home extends StatefulWidget {
  const Home({Key? key, String? uid}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Notes()));
              },
              child: Container(
                width: 250,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade400,
                          blurRadius: 2,
                          offset: Offset(2, 2),
                          spreadRadius: 2)
                    ]),
                child: Center(
                  child: Text(
                    "Tambah Note",
                    style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //         context, MaterialPageRoute(builder: (_) => SeeNotes(user: user,)));
            //   },
            //   child: Container(
            //     width: 250,
            //     height: 50,
            //     decoration: BoxDecoration(
            //         color: Color.fromARGB(255, 217, 67, 200),
            //         borderRadius: BorderRadius.circular(20),
            //         boxShadow: [
            //           BoxShadow(
            //               color: Colors.grey.shade400,
            //               blurRadius: 2,
            //               offset: Offset(2, 2),
            //               spreadRadius: 2)
            //         ]),
            //     child: Center(
            //       child: Text(
            //         "Lihat Note",
            //         style: TextStyle(
            //             fontSize: 26,
            //             color: Colors.white,
            //             fontWeight: FontWeight.bold),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}




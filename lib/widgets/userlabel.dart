// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, unnecessary_string_interpolations

import 'package:flutter/material.dart';

class Labellogin extends StatelessWidget {
  Labellogin({
    Key? key,
    required this.title,
    required this.txtcolor,
    required this.txtsize,
  }) : super(key: key);

  final String title;
  final Color txtcolor;
  final double txtsize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25, top: 20),
      child: Text(
        "$title",
        style: TextStyle(
            fontSize: txtsize,
            // color: Color.fromARGB(255, 214, 214, 214),
            color: txtcolor,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}

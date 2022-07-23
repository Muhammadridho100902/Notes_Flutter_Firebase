// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class subTitled extends StatelessWidget {
  const subTitled({
    Key? key, required this.Titled,
  }) : super(key: key);

  final String Titled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25, bottom: 20),
      child: Text(
        "$Titled",
        style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}


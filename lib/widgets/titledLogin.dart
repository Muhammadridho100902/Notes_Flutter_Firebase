// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Titled extends StatelessWidget {
  const Titled({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 30, 25, 10),
      child: Text(
        "Note Reminders.",
        style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

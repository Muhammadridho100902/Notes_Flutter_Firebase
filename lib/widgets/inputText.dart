// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';

class inputText extends StatelessWidget {
  const inputText({
    Key? key, required this.label, required this.color, required this.controller,
  }) : super(key: key);

  final String label;
  final Color color;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
      child: TextFormField(
        decoration: InputDecoration(
          border:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          // focusColor: Colors.white,
          // fillColor: Colors.white,
          hintText: '$label',
          hintStyle: TextStyle(color: color)
        ),
        style: TextStyle(color: color),
        controller: controller,
        validator: (value){
          if (value != null && value.isEmpty) {
            return "Enter The Field";
          }
          return null;
        },
        // cursorColor: Colors.white,
      ),
    );
  }
}

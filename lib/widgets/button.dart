// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';

class button extends StatelessWidget {
  const button({
    Key? key,
    required this.txt,
    required this.colors,
    required this.height,
    required this.width,
    required this.txtcolor,
  }) : super(key: key);

  final String txt;
  final Color colors;
  final double height;
  final double width;
  final Color txtcolor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(25),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: colors,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              txt,
              style: TextStyle(
                  fontSize: 20, color: txtcolor, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

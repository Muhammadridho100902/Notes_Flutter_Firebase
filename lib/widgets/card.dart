// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({
    Key? key,
    required this.titled,
    required this.subtitled,
    required this.img,
    required this.color,
  }) : super(key: key);

  final String titled;
  final String subtitled;
  final String? img;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 10, 20),
      padding: EdgeInsets.only(bottom: 15),
      width: MediaQuery.of(context).size.width / 2.5,
      height: 150,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 174, 174, 174),
                blurRadius: 3,
                offset: Offset(1, 1),
                spreadRadius: 1),
          ]),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Image.asset("${img}"),
          ),
          Text(
            titled,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5),
          ),
          Text(
            subtitled,
            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ],
      )),
    );
  }
}

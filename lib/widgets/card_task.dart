// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class card_task_progress extends StatelessWidget {
  const card_task_progress({
    Key? key,
    required this.count,
    required this.title,
    required this.width,
    required this.height,
  }) : super(key: key);
  final String count;
  final String title;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 254, 254, 254),
          border: Border.all(color: Colors.grey.shade400)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              count,
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[400]),
            ),
          ],
        ),
      ),
    );
  }
}

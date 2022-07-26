// ignore_for_file: prefer_const_constructors, must_be_immutable, camel_case_types, unused_field

import 'package:flutter/material.dart';
import 'package:project_3/widgets/userlabel.dart';

class Date_Card extends StatelessWidget {
  Date_Card({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  late DateTime _myDatetime;
  String time = '?';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Labellogin(
            title: title,
            txtcolor: Colors.black,
            txtsize: 20,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 5, 0, 0),
            child: Text(
              time,
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 5, 0, 0),
            child: ElevatedButton(
              onPressed: () async {
                _myDatetime = (await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2015),
                  lastDate: DateTime(2025),
                ))!;
              },
              child: Text("Choose the date"),
            ),
          )
        ],
      ),
    );
  }
}

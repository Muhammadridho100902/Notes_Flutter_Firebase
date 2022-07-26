// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project_3/model/usermodel.dart';
import 'package:project_3/service/authenticate.dart';
import 'package:project_3/view/seenote.dart';
import 'package:provider/provider.dart';

class AuthSelector extends StatefulWidget {
  const AuthSelector({Key? key}) : super(key: key);

  @override
  _AuthSelectorState createState() => _AuthSelectorState();
}

class _AuthSelectorState extends State<AuthSelector> {
  final fb = FirebaseDatabase.instance;

  // final ref = fb.ref().child('users/$UserModel.userId/notes/$k');

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    if (user != null) {
      // return SeeNotes(
      //   user: user,
      // );
      return SeeNotes();
    } else {
      return const Authenticate();
    }
  }
}

// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:project_3/model/usermodel.dart';
import 'package:project_3/view/home.dart';
import 'package:project_3/view/onboarding.dart';
import 'package:project_3/view/seenote.dart';
import 'package:provider/provider.dart';

const String onboarding = 'onboarding';
const String home = 'home';
const String login = 'login';
const String signup = 'signup';
const String note = 'note';
const String seenotes  = 'seenotes';

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case onboarding:
      return MaterialPageRoute(
        builder: (context) => Onboarding(),
      );
    case home:
      return MaterialPageRoute(
        builder: (context) => const Home(),
      );
    // case note:
    //   BuildContext context;
    //   // var user = Provider.of<UserModel>bul;
    //   return MaterialPageRoute(
    //     builder: (context) => SeeNotes(user: user),
    //   );
    default:
      throw ("No Page");
  }
}

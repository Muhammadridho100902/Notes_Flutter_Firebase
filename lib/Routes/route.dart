// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:project_3/view/home.dart';
import 'package:project_3/view/onboarding.dart';

const String onboarding = 'onboarding';
const String home = 'home';
const String login = 'login';
const String signup = 'signup';
const String note = 'note';

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
    //   return MaterialPageRoute(
    //     builder: (context) => (),
    //   );
    default:
      throw ("No Page");
  }
}

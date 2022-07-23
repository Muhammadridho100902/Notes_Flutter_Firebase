import 'package:flutter/material.dart';
import 'package:project_3/model/usermodel.dart';
import 'package:project_3/service/auth_service.dart';

class HomePage extends StatefulWidget {
  // final String nameUser;
  final UserModel user;
  const HomePage({
    Key? key,
    required this.user,
    // required this.nameUser,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Authentication"),
        actions: [
          TextButton(
            onPressed: () async {
              await _authService
                  .signout()
                  // ignore: avoid_print
                  .then((value) => print(value.toString()));
            },
            child: Row(
              children: const [
                Icon(Icons.logout, color: Colors.white),
                Text(
                  " Sign out",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "User Email: ${widget.user.email}",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "User Id: ${widget.user.userId}",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //     "Your name: ${widget.user.name}",
          //     style: Theme.of(context).textTheme.headline6,
          //   ),
          // ),
        ],
      ),
    );
  }
}

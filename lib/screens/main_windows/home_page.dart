import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../authentication/log_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
      actions: [
        IconButton(
            onPressed: () {
              final auth = FirebaseAuth.instance;
              auth.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LogIn()));
            },
            icon: const Icon(Icons.abc))
      ],
    )));
  }
}

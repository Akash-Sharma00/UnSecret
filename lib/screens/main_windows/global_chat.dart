import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../authentication/log_in.dart';

class GlobalChat extends StatefulWidget {
  const GlobalChat({Key? key}) : super(key: key);

  @override
  State<GlobalChat> createState() => _GlobalChatState();
}

class _GlobalChatState extends State<GlobalChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Global Chat"),
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
        ),
        body: const Text("Global Chat"));
  }
}

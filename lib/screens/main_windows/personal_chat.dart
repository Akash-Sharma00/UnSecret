import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../resources/userHelper.dart';
import '../authentication/log_in.dart';

class PersonalChat extends StatefulWidget {
  const PersonalChat({
    Key? key,
  }) : super(key: key);

  @override
  State<PersonalChat> createState() => _PersonalChatState();
}

class _PersonalChatState extends State<PersonalChat> {
  final personal = FirebaseFirestore.instance
      .collection('personal-chats/');
  String? Lid, Cid;

  @override
  void initState() {
    super.initState();
  }

  getides() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Personal Chat"),
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
        body: StreamBuilder(
            stream: personal
                .orderBy(MessageField.createdAt, descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    reverse: true,
                    itemCount:5,
                    itemBuilder: (context, index) {
                      return  Text(
                        snapshot.data.toString(),
                        style: const TextStyle(color: Colors.red),
                      );
                    });
              }
              return Container(
                color: Colors.red,
              );
            }
            //  const Text("Personal Chat")
            ));
  }
}

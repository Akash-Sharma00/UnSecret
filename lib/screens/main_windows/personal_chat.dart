import 'package:flutter/material.dart';

class PersonalChat extends StatefulWidget {
  const PersonalChat({Key? key}) : super(key: key);

  @override
  State<PersonalChat> createState() => _PersonalChatState();
}

class _PersonalChatState extends State<PersonalChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Personal Chat")),
        body: const Text("Personal Chat"));
  }
}

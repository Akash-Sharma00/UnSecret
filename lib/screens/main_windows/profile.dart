import 'dart:io';

import 'package:flutter/material.dart';
import 'package:unsecret/connect_to_fire.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final data = ConnectToFire();
  late Map profile;

  @override
  void initState() {
    print("Hello");
    getData();
    setState(() {});
    super.initState();
  }

  getData() async {
    profile = await data.getLocalData();
    print(profile);
    // print(profile[5].runtimeType);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    
    final image = FileImage(File(profile['path']));

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(profile['name']),
              Text(profile['userid']),
              Text(profile['email']),
              Text(profile['contact']),
              Text(profile['mode'].toString()),
              Text(profile[4].toString()),
              Image(image: image),
            ],
          ),
        ),
      ),
    );
  }
}

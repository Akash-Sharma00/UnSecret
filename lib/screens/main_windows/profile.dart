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
    // final image = FileImage(File(profile['path'] as ImageProvider) );

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
              // Image(image: image),
              Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/unsecret-e1fc6.appspot.com/o/profiles%2Fprofiles?alt=media&token=01265c18-5042-44fe-9078-ae2741726cb5')
            ],
          ),
        ),
      ),
    );
  }
}

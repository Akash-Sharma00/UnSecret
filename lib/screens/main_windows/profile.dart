import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unsecret/connect_to_fire.dart';
import 'package:unsecret/screens/authentication/log_in.dart';
import '../../resources/chat_containers.dart';
import '../../resources/userHelper.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final data = ConnectToFire();
  Map profile = {};

  @override
  void initState() {
    getData();
    setState(() {});
    super.initState();
  }

  getData() async {
    profile = await data.getLocalData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.green[50],
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => signOutBox());
                                    },
                                    child: const Text("Sign Out")),
                              )
                            ]),
                        const SizedBox(
                          height: 10,
                        ),
                        profile['url'] == null
                            ? Image.asset('asset/default_profile.png',
                                height: 120, width: 120, fit: BoxFit.cover)
                            : ClipOval(
                                child: Image.network(profile['url'],
                                    height: 120, width: 120, fit: BoxFit.cover),
                              ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          profile['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          profile['email'],
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('ID:- @${profile['userid']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text('Contact:- ${profile['contact']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 48,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: TabBar(
                          unselectedLabelColor: Colors.black,
                          indicator: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10)),
                          tabs: const [
                            Tab(
                              text: "Media",
                            ),
                            Tab(
                              text: "Post",
                            )
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.62,
                    child: TabBarView(children: [
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('global-chat')
                              .orderBy(MessageField.createdAt, descending: true)
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: snapshot.data?.docs.length,
                                  itemBuilder: (context, index) {
                                    if (snapshot.data?.docs[index]['id'] ==
                                            profile['userid'] &&
                                        snapshot.data?.docs[index]
                                                ['mediapost'] !=
                                            null) {
                                      return senderContainer(
                                          snapshot.data?.docs[index]
                                              ['timeStamp'],
                                          '',
                                          snapshot.data?.docs[index]['id'],
                                          snapshot.data?.docs[index]['dpUrl'],
                                          MediaQuery.of(context).size.width,
                                          snapshot.data?.docs[index]
                                              ['mediapost'],
                                          context,
                                          '');
                                    } else {
                                      return Container();
                                    }
                                  });
                            }
                            return Container();
                          }),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('global-chat')
                              .orderBy(MessageField.createdAt, descending: true)
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: snapshot.data?.docs.length,
                                  itemBuilder: (context, index) {
                                    if (snapshot.data?.docs[index]['id'] ==
                                            profile['userid'] &&
                                        snapshot.data?.docs[index]
                                                ['mediapost'] ==
                                            null) {
                                      return senderContainer(
                                          snapshot.data?.docs[index]
                                              ['timeStamp'],
                                          snapshot.data?.docs[index]['message'],
                                          snapshot.data?.docs[index]['id'],
                                          snapshot.data?.docs[index]['dpUrl'],
                                          MediaQuery.of(context).size.width,
                                          // snapshot.data?.docs[index]
                                          //     ['mediapost']
                                          null,
                                          context,
                                          '');
                                    } else {
                                      return Container();
                                    }
                                  });
                            }
                            return Container();
                          }),
                    ]),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  signOutBox() {
    return AlertDialog(
      content: const Text("Are you sure you want to sign out"),
      actions: [
        TextButton(
            onPressed: () {
              final auth = FirebaseAuth.instance;
              auth.signOut();
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LogIn(),
                  ));
            },
            child: const Text("Yes")),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("No"))
      ],
    );
  }
}

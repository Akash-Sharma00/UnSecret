import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unsecret/connect_to_fire.dart';
import 'package:unsecret/screens/main_windows/chatting/chat_in_private.dart';
import '../../authentication/log_in.dart';

class PersonalChat extends StatefulWidget {
  const PersonalChat({
    Key? key,
  }) : super(key: key);

  @override
  State<PersonalChat> createState() => _PersonalChatState();
}

class _PersonalChatState extends State<PersonalChat> {
  Map profile = {};
  final data = ConnectToFire();

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
    return Scaffold(
        appBar: AppBar(
          title: const Text("personal-chats"),
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
            stream: FirebaseFirestore.instance
                .collection('personal-chats/${profile['userid']}/connects')
                // .orderBy(MessageField.createdAt, descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              print(profile['userid']);

              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      return chatList(
                          snapshot.data?.docs[index]['dp'],
                          snapshot.data?.docs[index]['id'],
                          "The Last Message jfhdgf dfgjhdbf ufhgk fhfdkjvgfkghfjghf kfdjghg fh fh sdjf sdhgkfdkfd kfd");
                    });
              } else {
              }
              return Container(
                color: Colors.red,
              );
            }));
  }

  Widget chatList(String? dp, String userid, String? lastMessage) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChatInPrivate(
                  id: userid,
                  dp: dp,
                  pid: profile['userid'],
                )));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        height: 90,
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(color: Colors.grey[100]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dp == null
                ? Image.asset('asset/default_profile.png',
                    height: 70, width: 70, fit: BoxFit.cover)
                : ClipOval(
                    child: Image.network(dp,
                        height: 70, width: 70, fit: BoxFit.cover),
                  ),
            const SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userid,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  lastMessage!.substring(0, 20),
                  style: const TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.grey),
                ),
              ],
            ),
            const Text("data"),
          ],
        ),
      ),
    );
  }
}

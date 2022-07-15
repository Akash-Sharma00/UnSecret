import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unsecret/resources/userHelper.dart';
import 'package:unsecret/screens/main_windows/share_img.dart';

import '../../connect_to_fire.dart';
import '../../resources/chat_containers.dart';

class GlobalChat extends StatefulWidget {
  const GlobalChat({Key? key}) : super(key: key);

  @override
  State<GlobalChat> createState() => _GlobalChatState();
}

class _GlobalChatState extends State<GlobalChat> {
  String tex = "This is new and helthy";
  final data = ConnectToFire();
  late Map profile;
  TextEditingController messages = TextEditingController();
  final globalChat = FirebaseFirestore.instance.collection('global-chat');
  ConnectToFire connect = ConnectToFire();
  List<String> allPic = [];

  @override
  void initState() {
    getData();
    setState(() {});
    super.initState();
  }

  getData() async {
    profile = await data.getLocalData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Global Chat"),
        actions: [
          TextButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.switch_right_rounded,
                color: Colors.white,
              ),
              label: const Text("Switch Topic",
                  style: TextStyle(
                    color: Colors.white,
                  ))),
          Stack(children: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.notifications_active)),
            const Visibility(
              visible: false,
              child: Positioned(
                top: 5,
                left: 20,
                child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red,
                    child: Text(
                      "2",
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    )),
              ),
            ),
          ])
        ],
      ),
      body: StreamBuilder(
          stream: globalChat
              .orderBy(MessageField.createdAt, descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  reverse: true,
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    if (snapshot.data?.docs[index]['mediapost'] != null) {
                      allPic.insert(0, snapshot.data?.docs[index]['mediapost']);
                    }
                    if (snapshot.data?.docs[index]['id'] != profile['userid']) {
                      return senderContainer(
                          snapshot.data?.docs[index]['timeStamp'],
                          snapshot.data?.docs[index]['message'],
                          snapshot.data?.docs[index]['id'],
                          snapshot.data?.docs[index]['dpUrl'],
                          MediaQuery.of(context).size.width,
                          snapshot.data?.docs[index]['mediapost'],
                          allPic);
                    } else {
                      return receiverContainer(
                          snapshot.data?.docs[index]['dpUrl'],
                          snapshot.data?.docs[index]['timeStamp'],
                          snapshot.data?.docs[index]['message'],
                          snapshot.data?.docs[index]['id'],
                          MediaQuery.of(context).size.width,
                          snapshot.data?.docs[index]['mediapost'],
                          allPic);
                    }
                  });
            }
            return senderContainer('', "message", "id", null, 200, null, null);
          }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.78,
              child: TextField(
                controller: messages,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    prefixIcon: IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: ((context) {
                            return ShareImg(
                                id: profile['userid'],
                                header: 'Global',
                                dpulr: profile['url']);
                          })));
                        },
                        icon: const Icon(Icons.camera_alt_outlined)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: "Enter Message",
                    filled: true,
                    fillColor: Colors.green[50]),
              ),
            ),
            ClipOval(
              child: Material(
                color: Colors.green, // Button color
                child: InkWell(
                  onTap: () {
                    if (messages.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please Enter Message")));
                    } else {
                      connect.saveToGlobal(profile['url'], profile['userid'],
                          messages.text, null);
                    }
                    setState(() {
                      messages.clear();
                    });
                  },
                  child: const SizedBox(
                      width: 56, height: 56, child: Icon(Icons.send)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

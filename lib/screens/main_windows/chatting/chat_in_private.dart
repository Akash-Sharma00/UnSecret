import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unsecret/connect_to_fire.dart';
import 'package:unsecret/resources/chat_containers.dart';
import 'package:unsecret/resources/userHelper.dart';

import '../share_img.dart';

class ChatInPrivate extends StatefulWidget {
  final String id, pid;
  final String? dp;
  const ChatInPrivate({Key? key, required this.id, this.dp, required this.pid})
      : super(key: key);

  @override
  State<ChatInPrivate> createState() => _ChatInPrivateState();
}

class _ChatInPrivateState extends State<ChatInPrivate> {
  TextEditingController messages = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ConnectToFire connect = ConnectToFire();
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.green[50],

      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            widget.dp == null
                ? Image.asset('asset/private_chat_icon.png',
                    height: 50, width: 50, fit: BoxFit.cover)
                : InkWell(
                    onTap: () {},
                    child: ClipOval(
                        child: Image.network(widget.dp!,
                            height: 50, width: 50, fit: BoxFit.cover)),
                  ),
            const SizedBox(
              width: 10,
            ),
            Text(widget.id),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("all-chats/${widget.pid}/${widget.id}")
                    .orderBy(MessageField.createdAt, descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        reverse: true,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          if (snapshot.data?.docs[index]['id'] != widget.pid) {
                            return personalSenderContainer(
                                snapshot.data?.docs[index]['time'],
                                snapshot.data?.docs[index]['message'],
                                snapshot.data?.docs[index]['id'],
                                null,
                                MediaQuery.of(context).size.width,
                                snapshot.data?.docs[index]['picture'],
                                context,
                                widget.pid);
                          } else {
                            return personalReceiverContainer(
                                null,
                                snapshot.data?.docs[index]['time'],
                                snapshot.data?.docs[index]['message'],
                                snapshot.data?.docs[index]['id'],
                                MediaQuery.of(context).size.width,
                                snapshot.data?.docs[index]['picture'],
                                context);
                          }
                        });
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
          Padding(
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
                                  pid: widget.pid,
                                  id: widget.id,
                                  header: widget.id,
                                  dpulr: null,
                                  des: "personal",
                                );
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
                          return;
                        } else {
                          connect.saveAllChat(
                              widget.pid, widget.id, messages.text, null);
                          messages.clear();
                        }
                      },
                      child: const SizedBox(
                          width: 56, height: 56, child: Icon(Icons.send)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(4.0),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       SizedBox(
      //         width: MediaQuery.of(context).size.width * 0.78,
      //         child: TextField(
      //           controller: messages,
      //           keyboardType: TextInputType.multiline,
      //           decoration: InputDecoration(
      //               prefixIcon: IconButton(
      //                   onPressed: () {
      //                     Navigator.of(context)
      //                         .push(MaterialPageRoute(builder: ((context) {
      //                       return const ShareImg(
      //                           id: "profile['userid']",
      //                           header: 'Global',
      //                           dpulr: " profile['url']");
      //                     })));
      //                   },
      //                   icon: const Icon(Icons.camera_alt_outlined)),
      //               border: OutlineInputBorder(
      //                   borderRadius: BorderRadius.circular(10)),
      //               hintText: "Enter Message",
      //               filled: true,
      //               fillColor: Colors.green[50]),
      //         ),
      //       ),
      //       ClipOval(
      //         child: Material(
      //           color: Colors.green, // Button color
      //           child: InkWell(
      //             onTap: () {
      //               if (messages.text.isEmpty) {
      //                 return;
      //               } else {
      //                 connect.saveAllChat(
      //                     widget.pid, widget.id, messages.text, null);
      //                 messages.clear();
      //               }
      //             },
      //             child: const SizedBox(
      //                 width: 56, height: 56, child: Icon(Icons.send)),
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    ));
  }
}

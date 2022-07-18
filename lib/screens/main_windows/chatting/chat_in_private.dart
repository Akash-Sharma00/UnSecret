import 'package:flutter/material.dart';
import 'package:unsecret/connect_to_fire.dart';

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
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            widget.dp == null
                ? Image.asset('asset/default_profile.png',
                    height: 30, width: 30, fit: BoxFit.cover)
                : InkWell(
                    onTap: () {},
                    child: ClipOval(
                        child: Image.network(widget.dp!,
                            height: 30, width: 30, fit: BoxFit.cover)),
                  ),
            const SizedBox(
              width: 10,
            ),
            Text(widget.id),
          ],
        ),
        // leading: widget.dp == null
        //     ? Image.asset('asset/default_profile.png',
        //         height: 30, width: 30, fit: BoxFit.cover)
        //     : InkWell(
        //         onTap: () {},
        //         child: ClipOval(
        //             child: Image.network(widget.dp!,
        //                 height: 30, width: 30, fit: BoxFit.cover)),
        //       )
      ),
      body: Container(),
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
                            return const ShareImg(
                                id: "profile['userid']",
                                header: 'Global',
                                dpulr: " profile['url']");
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
    ));
  }
}

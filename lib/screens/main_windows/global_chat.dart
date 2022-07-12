import 'package:flutter/material.dart';

class GlobalChat extends StatefulWidget {
  const GlobalChat({Key? key}) : super(key: key);

  @override
  State<GlobalChat> createState() => _GlobalChatState();
}

class _GlobalChatState extends State<GlobalChat> {
  String tex = "This is new and helthy";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Global Chat"),
          actions: [
            Stack(children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_active)),
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  children: [
                    const Text(
                      "This is global chat everything is public so don't share private data here",
                      style: TextStyle(fontSize: 8, color: Colors.red),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [
                        TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.switch_right_rounded),
                            label: const Text("Switch to Topic")),
                        for (int i = 0; i <= 10; i++)
                          TopicWidget(
                            tex: tex,
                          ),
                      ]),
                    ),
                  ],
                ),
              ),
              // color: Colors.amber,
              const Text("No chats availabe",style: (TextStyle(color: Colors.grey)),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.78,
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          prefixIcon: IconButton(
                              onPressed: () {},
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
                        onTap: () {},
                        child: const SizedBox(
                            width: 56, height: 56, child: Icon(Icons.send)),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}

class TopicWidget extends StatelessWidget {
  const TopicWidget({
    Key? key,
    required this.tex,
  }) : super(key: key);

  final String tex;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 4, right: 4),
        alignment: Alignment.center,
        height: 30,
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.green,
        ),
        child: Text(tex,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)));
  }
}

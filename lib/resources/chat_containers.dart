import 'package:flutter/material.dart';
import 'package:unsecret/connect_to_fire.dart';
import 'package:unsecret/screens/main_windows/gallery.dart';

Widget senderContainer(String period, String? message, String id, String? dp,
    double w, String? mediaPost, BuildContext context, String pId) {
  return Container(
    margin: EdgeInsets.only(left: 10, top: 5, bottom: 5, right: w * 0.18),
    alignment: Alignment.centerLeft,
    constraints: BoxConstraints(maxWidth: w * 0.7),
    padding: const EdgeInsets.all(15),
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
          topRight: Radius.circular(25)),
      color: Colors.white,
    ),
    child: Column(
      children: [
        InkWell(
          onTap: () {
            ConnectToFire().setPersonalChat(pId, id, "message", null, dp);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  dp == null
                      ? Image.asset('asset/default_profile.png',
                          height: 30, width: 30, fit: BoxFit.cover)
                      : InkWell(
                          onTap: () {},
                          child: ClipOval(
                              child: Image.network(dp,
                                  height: 30, width: 30, fit: BoxFit.cover)),
                        ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    id,
                    style: const TextStyle(color: Colors.blue),
                  ),
                ],
              ),
              Text(
                period.toString(),
                style: const TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
        const Divider(
          color: Colors.green,
        ),
        const SizedBox(
          height: 7,
        ),
        mediaPost == null
            ? Text(textAlign: TextAlign.left, message!)
            : InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return Gallery(pics: [mediaPost]);
                  }));
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(mediaPost)),
              ),
      ],
    ),
  );
}

Widget receiverContainer(String? dp, String period, String? message, String id,
    double w, String? mediaPost, BuildContext context) {
  return Container(
    margin: EdgeInsets.only(top: 5, bottom: 5, left: w * 0.2, right: 10),
    alignment: Alignment.centerRight,
    constraints: BoxConstraints(maxWidth: w * 0.7, minWidth: 50),
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
          topLeft: Radius.circular(25)),
      color: Colors.green[200],
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                dp == null
                    ? Image.asset('asset/default_profile.png',
                        height: 30, width: 30, fit: BoxFit.cover)
                    : ClipOval(
                        child: Image.network(dp,
                            height: 30, width: 30, fit: BoxFit.cover)),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  id,
                  style: const TextStyle(color: Colors.blue),
                ),
              ],
            ),
            Text(
              period,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        const Divider(
          color: Colors.green,
        ),
        const SizedBox(
          height: 7,
        ),
        mediaPost == null
            ? Text(textAlign: TextAlign.left, message!)
            : InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return Gallery(pics: [mediaPost]);
                  }));
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(mediaPost)),
              ),
      ],
    ),
  );
}

Widget personalSenderContainer(String period, String? message, String id,
    String? dp, double w, String? mediaPost, BuildContext context, String pId) {
  return Container(
    margin: EdgeInsets.only(left: 10, top: 5, bottom: 5, right: w * 0.18),
    alignment: Alignment.centerLeft,
    constraints: BoxConstraints(maxWidth: w * 0.7),
    padding: const EdgeInsets.all(15),
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
          topRight: Radius.circular(25)),
      color: Colors.white,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          period,
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(
          height: 7,
        ),
        mediaPost == null
            ? Text(textAlign: TextAlign.left, message!)
            : InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return Gallery(pics: [mediaPost]);
                  }));
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(mediaPost)),
              ),
      ],
    ),
  );
}

Widget personalReceiverContainer(String? dp, String period, String? message,
    String id, double w, String? mediaPost, BuildContext context) {
  return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5, left: w * 0.2, right: 10),
      alignment: Alignment.centerRight,
      constraints: BoxConstraints(maxWidth: w * 0.7),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
            topLeft: Radius.circular(25)),
        color: Colors.green[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
        Text(
          period,
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(
          height: 7,
        ),
        mediaPost == null
            ? Text(textAlign: TextAlign.left, message!)
            : InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return Gallery(pics: [mediaPost]);
                  }));
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(mediaPost)),
              ),
       
      ]));
}

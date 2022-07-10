import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectToFire {
  final user = FirebaseFirestore.instance.collection('users');
  final auth = FirebaseAuth.instance;
  late SharedPreferences? pref;

  Future<void> saveData(String name, String userID, String email,
      String contact, String password, String img) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final data = {
        'name': name,
        'userId': userID,
        'email': email,
        'contact': contact,
        'image': img
      };
      await user.doc(userID).set(data);
      auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString().substring(37),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.red,
          fontSize: 16.0);
    }
  }

  Future<bool?> getData(String userID) async {
    await for (var messages in user.snapshots()) {
      for (var message in messages.docs.toList()) {
        if (message.id.contains(userID)) {
          return Future.value(true);
        }
      }
      return Future.value(false);
    }
    return null;
  }

  static UploadTask? uploadImg(String des, File file) {
    try {
      final storage = FirebaseStorage.instance.ref().child('profiles/$des');
      return storage.putFile(file);
    } on FirebaseException {
      return null;
    }
  }

  Future saveLocal(String name, String userid, String email, String contact,
      bool mode) async {
    pref = await SharedPreferences.getInstance();
    pref!.clear();
    Map dataSet = {
      'name': name,
      'userid': userid,
      'email': email,
      'contact': contact,
      'mode': mode,
    };
    String rawData = jsonEncode(dataSet);
    await pref!.setString("profile", rawData);
  }

  getLocalData() async {
    pref = await SharedPreferences.getInstance();
    final String? rawJson = pref!.getString('profile');
    Map<String, dynamic> map = await jsonDecode(rawJson!);
    return map;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConnectToFire {
  // String? name, userId, email, contact;
  final user = FirebaseFirestore.instance.collection('users');
  final auth = FirebaseAuth.instance;

  Future<void> saveData(String name, String userID, String email,
      String contact, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final data = {
        'name': name,
        'userId': userID,
        'email': email,
        'contact': contact
      };
      await user.doc(userID).set(data);
      auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
          msg: e.toString().substring(37),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
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
}

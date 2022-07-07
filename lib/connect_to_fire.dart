import 'package:cloud_firestore/cloud_firestore.dart';

class ConnectToFire {
  String? name, userId, email, contact;
  final user = FirebaseFirestore.instance.collection('users');

  Future<void> saveData(
      String name, String userID, String email, String contact) async {
    final data = {
      'name': name,
      'userId': userID,
      'email': email,
      'contact': contact
    };
    await user.doc(userId).set(data);
  }

  Future<bool> getData(String UserID) async {
    await for (var messages in user.snapshots()) {
      for (var message in messages.docs.toList()) {
        if (userId == message.id) {
          return false;
        }
      }
    }
    return true;
  }
}

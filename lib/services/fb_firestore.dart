import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FbFirestore {
  static DateTime dateTime = DateTime.now();
  static final CollectionReference _chat = FirebaseFirestore.instance
      .collection("messages");
  static Future<void> addMessage(String message) async {
    await _chat
        .add({
          "message": message,
          "senderEmail": FirebaseAuth.instance.currentUser!.email,
          "time": FieldValue.serverTimestamp(),
        })
        .then((value) => print("object was added succesfuly"))
        .onError((error, v) => print("an error occured $error"));
  }

  static Future<void> deleteMessage(String id) async {
    await _chat
        .doc(id)
        .delete()
        .then((value) => print("object was deleted succesfuly"))
        .onError((error, v) => print("an error occured $error"));
  }

  static Future<void> updateMessage(String id, String newMessage) async {
    await _chat
        .doc(id)
        .update({"message": newMessage, "time": FieldValue.serverTimestamp()})
        .then((value) => print("object was updated succesfuly"))
        .onError((error, v) => print("an error occured $error"));
  }
}

import 'package:chat_me_app/services/fb_firestore.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static Future deletionDialog(
    BuildContext context,
    AsyncSnapshot snapshot,
    int index,
  ) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete message"),
        content: Text("Are you sure you want to delete this message?"),
        actions: [
          TextButton(
            onPressed: () async {
              await FbFirestore.deleteMessage(snapshot.data!.docs[index].id);
              Navigator.pop(context);
            },
            child: Text("Yes", style: TextStyle(color: Colors.blue)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("No", style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  static Future updateDialog(
    BuildContext context,
    AsyncSnapshot snapshot,
    int index,
    TextEditingController editMessage,
  ) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit message"),
        content: TextField(controller: editMessage),
        actions: [
          TextButton(
            onPressed: () async {
              await FbFirestore.updateMessage(
                snapshot.data!.docs[index].id,
                editMessage.text.trim(),
              );
              Navigator.pop(context);
            },
            child: Text("Save", style: TextStyle(color: Colors.blue)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel", style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }
}

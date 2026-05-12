import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageDisplay extends StatelessWidget {
  const MessageDisplay({super.key, required this.text, required this.email});
  final String text;
  final String email;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: email == FirebaseAuth.instance.currentUser!.email
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Text(email, style: TextStyle(fontSize: 12, color: Colors.black45)),
        Card(
          color: email == FirebaseAuth.instance.currentUser!.email
              ? Colors.blue
              : Colors.grey[400],
          margin: EdgeInsets.only(top: 2, bottom: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

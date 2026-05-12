import 'package:chat_me_app/services/fb_firestore.dart';
import 'package:chat_me_app/view/screens/welcoming_screen.dart';
import 'package:chat_me_app/view/widgets/dialogs.dart';
import 'package:chat_me_app/view/widgets/message_display.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static final String chatScreenRoute = "chat_screen";

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController message = TextEditingController();
  final TextEditingController editMessage = TextEditingController();
  @override
  void dispose() {
    message.dispose();
    editMessage.dispose();
    super.dispose();
  }

  final snapshot = FirebaseFirestore.instance
      .collection("messages")
      .orderBy("time", descending: true)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: AppBar(
          title: Text(
            "${user!.email}",
            style: Theme.of(context).textTheme.titleLarge,
          ),

          backgroundColor: Colors.blue,
          actions: [
            IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut().then(
                  (value) => Navigator.pushNamedAndRemoveUntil(
                    context,
                    WelcomeScreen.welcomeScreenRoute,
                    (context) => false,
                  ),
                );
              },
              icon: Icon(Icons.exit_to_app_rounded),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: snapshot,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      reverse: true,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 20,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onDoubleTap: () {
                            if (snapshot.data!.docs[index]["senderEmail"] ==
                                user.email) {
                              Dialogs.updateDialog(
                                context,
                                snapshot,
                                index,
                                editMessage,
                              );
                            }
                          },
                          onLongPress: () {
                            if (snapshot.data!.docs[index]["senderEmail"] ==
                                user.email) {
                              Dialogs.deletionDialog(context, snapshot, index);
                            }
                          },
                          child: MessageDisplay(
                            text: snapshot.data!.docs[index]["message"],
                            email: snapshot.data!.docs[index]["senderEmail"],
                          ),
                        );
                      },
                      itemCount: snapshot.data!.docs.length,
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.blue),
                    );
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(width: 2, color: Colors.blue)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: message,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type your message here",
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (message.text.trim().isNotEmpty) {
                        await FbFirestore.addMessage(message.text.trim());
                        message.clear();
                      }
                    },
                    child: Text("Send", style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

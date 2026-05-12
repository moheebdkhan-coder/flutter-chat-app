import 'package:chat_me_app/view/screens/chat_screen.dart';
import 'package:chat_me_app/view/screens/log_in_screen.dart';
import 'package:chat_me_app/view/screens/register_screen.dart';
import 'package:chat_me_app/view/screens/welcoming_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('============================User is currently signed out!');
    } else {
      print('=========================User is signed in!');
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? WelcomeScreen.welcomeScreenRoute
          : ChatScreen.chatScreenRoute,
      debugShowCheckedModeBanner: false,
      routes: {
        WelcomeScreen.welcomeScreenRoute: (context) => WelcomeScreen(),
        RegisterScreen.registerScreenRoute: (context) => RegisterScreen(),
        LoginScreen.loginScreenRoute: (context) => LoginScreen(),
        ChatScreen.chatScreenRoute: (context) => ChatScreen(),
      },
    );
  }
}

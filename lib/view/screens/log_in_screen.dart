import 'package:chat_me_app/services/auth_services/fb_auth.dart';
import 'package:chat_me_app/view/screens/chat_screen.dart';
import 'package:chat_me_app/view/screens/register_screen.dart';
import 'package:chat_me_app/view/widgets/auth_buttons.dart';
import 'package:chat_me_app/view/widgets/auth_text_fields.dart';
import 'package:chat_me_app/view/widgets/titled_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String loginScreenRoute = "login_screen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.blue))
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: globalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 40),
                    Image.asset("images/logo.png", height: 180),
                    SizedBox(height: 10),
                    TitledText(text: "Log in"),
                    SizedBox(height: 30),
                    AuthTextFields(
                      myController: email,
                      isSecured: false,
                      hintText: "email",
                      preIcon: Icon(Icons.email),
                    ),
                    SizedBox(height: 8),
                    AuthTextFields(
                      myController: password,
                      isSecured: true,
                      hintText: "password",
                      preIcon: Icon(Icons.password),
                    ),
                    SizedBox(height: 8),
                    InkWell(
                      child: Text("forgot password?", textAlign: .end),
                      onTap: () async {
                        if (email.text.isEmpty) {
                          globalKey.currentState!.validate();
                        } else {
                          await FirebaseAuth.instance.sendPasswordResetEmail(
                            email: email.text.trim(),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "a reset email was sent to your email",
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 30),
                    AuthButtons(
                      onPressed: () async {
                        setState(() => isLoading = true);
                        String? error = await FbAuth.logInWithEmailPassword(
                          email.text,
                          password.text,
                        );
                        if (!mounted) return;
                        setState(() => isLoading = false);
                        if (error != null) {
                          print(error);
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(error)));
                        } else {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            ChatScreen.chatScreenRoute,
                            (context) => false,
                          );
                        }
                      },
                      color: Colors.blue,
                      text: "Log in",
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed(
                              RegisterScreen.registerScreenRoute,
                            );
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

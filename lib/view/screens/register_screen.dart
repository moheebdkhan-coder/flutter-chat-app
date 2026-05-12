import 'package:chat_me_app/services/auth_services/fb_auth.dart';
import 'package:chat_me_app/view/screens/chat_screen.dart';
import 'package:chat_me_app/view/screens/log_in_screen.dart';
import 'package:chat_me_app/view/widgets/auth_buttons.dart';
import 'package:chat_me_app/view/widgets/auth_text_fields.dart';
import 'package:chat_me_app/view/widgets/titled_text.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static const String registerScreenRoute = "register_screen";
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
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
                    TitledText(text: "Register"),
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
                    SizedBox(height: 30),
                    AuthButtons(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        String? error = await FbAuth.signUpWithEmailPassword(
                          email.text.trim(),
                          password.text.trim(),
                        );
                        if (!mounted) return;
                        setState(() {
                          isLoading = false;
                        });
                        if (error != null) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text("error")));
                        } else {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            ChatScreen.chatScreenRoute,
                            (context) => false,
                          );
                        }
                      },
                      color: Colors.blue,
                      text: "Register",
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              LoginScreen.loginScreenRoute,
                            );
                          },
                          child: Text(
                            "Login",
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

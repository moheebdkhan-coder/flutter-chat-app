import 'package:chat_me_app/view/screens/log_in_screen.dart';
import 'package:chat_me_app/view/screens/register_screen.dart';
import 'package:chat_me_app/view/widgets/auth_buttons.dart';
import 'package:chat_me_app/view/widgets/titled_text.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  static final String welcomeScreenRoute = "welcome_screen";
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TitledText(text: "Get Started"),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "Start with sign up or sign in",
                textAlign: TextAlign.center,
              ),
            ),
            Image.asset("images/logo.png"),
            AuthButtons(
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  RegisterScreen.registerScreenRoute,
                );
              },
              color: Colors.blue,
              text: "Sign up",
            ),
            SizedBox(height: 10),
            AuthButtons(
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  LoginScreen.loginScreenRoute,
                );
              },
              color: Colors.grey[400]!,
              text: "Log in",
            ),
          ],
        ),
      ),
    );
  }
}

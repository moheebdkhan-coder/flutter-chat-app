import 'package:flutter/material.dart';

class AuthButtons extends StatelessWidget {
  final Function()? onPressed;
  final Color color;
  final String text;
  const AuthButtons({
    super.key,
    required this.onPressed,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(color),
        padding: WidgetStatePropertyAll(EdgeInsets.all(12)),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
      ),
    );
  }
}

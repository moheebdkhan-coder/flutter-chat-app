import 'package:flutter/material.dart';

class TitledText extends StatelessWidget {
  final String text;
  const TitledText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.displayMedium,
    );
  }
}

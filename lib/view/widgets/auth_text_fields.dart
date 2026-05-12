import 'package:flutter/material.dart';

class AuthTextFields extends StatefulWidget {
  final TextEditingController myController;
  final bool isSecured;
  final String hintText;
  final Icon preIcon;
  const AuthTextFields({
    super.key,
    required this.myController,
    required this.isSecured,
    required this.hintText,
    required this.preIcon,
  });

  @override
  State<AuthTextFields> createState() => _AuthTextFieldsState();
}

class _AuthTextFieldsState extends State<AuthTextFields> {
  late bool obsecured;
  @override
  void initState() {
    obsecured = widget.isSecured;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      keyboardType: !widget.isSecured ? TextInputType.emailAddress : null,
      validator: (value) {
        if (!widget.isSecured &&
            !value!.endsWith(".com") &&
            !value.contains("@")) {
          return "please enter a valid email";
        }
        if (widget.isSecured && value!.length < 8) {
          return "password must have 8 charchters at least";
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: Colors.blue,
      cursorWidth: 2.5,
      obscureText: widget.isSecured ? obsecured : false,
      controller: widget.myController,
      decoration: InputDecoration(
        prefixIcon: widget.preIcon,
        hint: Text(
          widget.hintText,
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 2)),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 4),
        ),
        suffixIcon: widget.isSecured
            ? IconButton(
                onPressed: () {
                  setState(() {
                    obsecured = !obsecured;
                  });
                },
                icon: obsecured
                    ? Icon(Icons.visibility_outlined)
                    : Icon(Icons.visibility_off_outlined),
              )
            : null,
      ),
    );
  }
}

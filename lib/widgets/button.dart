import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String buttonText;

  const Button({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF6DBF73)),
        onPressed: () {},
        child: Text(
          buttonText,
          style: TextStyle(fontFamily: "Roboto Regular", fontSize: 18),
        ),
      ),
    );
  }
}

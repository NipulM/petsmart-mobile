// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cb011999/widgets/button.dart';
import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const HeroSection(
      {super.key,
      required this.title,
      required this.description,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Signika Medium',
              )),
          SizedBox(
            height: 15,
          ),
          Text(description,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Signika Regular',
              )),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Container(
              width: 200,
              child: Button(buttonText: "Choose a Plan"),
            ),
          )
        ],
      ),
    );
  }
}

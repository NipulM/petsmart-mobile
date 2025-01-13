// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  final String title;
  final String description;

  const HeroSection(
      {super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontFamily: 'Signika Bold',
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Signika Regular',
            ),
          ),
        ],
      ),
    );
  }
}

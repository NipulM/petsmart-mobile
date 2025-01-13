// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cb011999/screens/home/widgets/hero_section.dart';
import 'package:cb011999/screens/home/widgets/new_products_section.dart';
import 'package:flutter/material.dart';

class NewArrivalsSection extends StatelessWidget {
  final String title;
  final String description;

  const NewArrivalsSection(
      {super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeroSection(title: title, description: description),
          NewProductsSection()
        ],
      ),
    );
  }
}

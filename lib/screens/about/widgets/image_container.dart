// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final String imageUrl;

  const ImageContainer({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 225,
      width: double.infinity,
      child: Image(
        image: AssetImage(imageUrl),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class ProductImageCard extends StatelessWidget {
  final String imageUrl;

  const ProductImageCard({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color.fromARGB(255, 255, 255, 255)),
        // later on i have to change this to a network image
        // Image provider: NetworkImage("assets/images/single_product_example.png"...)
        child: Image(
          image: AssetImage("assets/images/single_product_example.png"),
        ));
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cb011999/screens/product/widgets/price_and_quantity_section.dart';
import 'package:cb011999/widgets/button.dart';
import 'package:flutter/material.dart';

class ProductDetailsCard extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final String category;

  const ProductDetailsCard({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color.fromARGB(255, 255, 255, 255),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontFamily: 'Signika Bold',
            ),
          ),
          Text(
            "#${category}",
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Signika Regular',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Signika Regular',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          PriceAndQuantitySection(price: "5.99"),
          SizedBox(
            height: 20,
          ),
          Button(
            buttonText: "Add to Cart",
          ),
        ],
      ),
    );
  }
}

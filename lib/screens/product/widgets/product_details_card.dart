// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cb011999/screens/product/widgets/price_and_quantity_section.dart';
import 'package:cb011999/widgets/button.dart';
import 'package:flutter/material.dart';

class ProductDetailsCard extends StatelessWidget {
  final String title;
  final String description;
  final double price;
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isDarkMode ? const Color(0xFF2C2C2C) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Roboto Bold',
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          Text(
            "#${category}",
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Roboto Regular',
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Roboto Regular',
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          PriceAndQuantitySection(price: price.toString()),
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

// ignore_for_file: prefer_const_constructors
import 'package:cb011999/screens/product/widgets/product_details_card.dart';
import 'package:cb011999/screens/product/widgets/product_image_card.dart';
import 'package:flutter/material.dart';

class SingleProductScreen extends StatelessWidget {
  const SingleProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final orientation = MediaQuery.of(context).orientation;
        if (orientation == Orientation.landscape) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Flexible(
                    flex: 45,
                    child: ProductImageCard(
                      imageUrl: "assets/images/single_product_example.png",
                    ),
                  ),
                  SizedBox(width: 16),
                  Flexible(
                    flex: 55,
                    child: ProductDetailsCard(
                      title: "Yarrah - Dry Dog Food for Small Breeds Bio",
                      description:
                          "Yarrah Organic Dog food Small Breeds has been specially developed for small dogs that weigh less than 15 kilos. This complete food is 100% organic, contains 23% chicken and is free from added sugars.",
                      price: 5.99,
                      category: "organic",
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                ProductImageCard(
                  imageUrl: "assets/images/single_product_example.png",
                ),
                ProductDetailsCard(
                  title: "Yarrah - Dry Dog Food for Small Breeds Bio",
                  description:
                      "Yarrah Organic Dog food Small Breeds has been specially developed for small dogs that weigh less than 15 kilos. This complete food is 100% organic, contains 23% chicken and is free from added sugars.",
                  price: 5.99,
                  category: "organic",
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

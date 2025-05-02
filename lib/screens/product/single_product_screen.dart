// ignore_for_file: prefer_const_constructors
import 'package:cb011999/screens/product/widgets/product_details_card.dart';
import 'package:cb011999/screens/product/widgets/product_image_card.dart';
import 'package:flutter/material.dart';

class SingleProductScreen extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final double price;
  final String category;

  const SingleProductScreen({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final orientation = MediaQuery.of(context).orientation;
          if (orientation == Orientation.landscape) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 45,
                      child: ProductImageCard(
                        imageUrl: imageUrl,
                      ),
                    ),
                    SizedBox(width: 16),
                    Flexible(
                      flex: 55,
                      child: ProductDetailsCard(
                        title: title,
                        description: description,
                        price: price,
                        category: category,
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
                children: [
                  ProductImageCard(
                    imageUrl: imageUrl,
                  ),
                  ProductDetailsCard(
                    title: title,
                    description: description,
                    price: price,
                    category: category,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

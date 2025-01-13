// ignore_for_file: prefer_const_constructors
import 'package:cb011999/screens/product/widgets/product_details_card.dart';
import 'package:cb011999/screens/product/widgets/product_image_card.dart';
import 'package:cb011999/widgets/bottom_navigation_bar.dart';
import 'package:cb011999/widgets/footer.dart';
import 'package:flutter/material.dart';

class SingleProductScreen extends StatelessWidget {
  const SingleProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details :)',
            style: TextStyle(
              fontFamily: "Signika Regular",
              fontWeight: FontWeight.bold, // Use font weight to specify bold
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            ProductImageCard(
                imageUrl: "assets/images/single_product_example.png"),
            ProductDetailsCard(
                title: "Yarrah - Dry Dog Food for Small Breeds Bio",
                description:
                    "Yarrah Organic Dog food Small Breeds has been specially developed for small dogs that weigh less than 15 kilos. This complete food is 100% organic, contains 23% chicken and is free from added sugars.",
                price: 5.99,
                category: "organic"),
            Footer(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cb011999/screens/home/widgets/new_product_item.dart';
import 'package:flutter/material.dart';

class NewProductsSection extends StatelessWidget {
  const NewProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            // Add this
            height: 400, // Adjust this value based on your needs
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: NewProductItem(
                      productName: "Original Blend",
                      productShortDescription:
                          "Organic Paws Kangaroo Recipe offers a natural, balanced meal for cats and dogs of all ages.",
                      productImage: "assets/images/single_product_example.png",
                      productPrice: 5.99),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: NewProductItem(
                      productName: "Original Blend",
                      productShortDescription:
                          "Organic Paws Kangaroo Recipe offers a natural, balanced meal for cats and dogs of all ages.",
                      productImage: "assets/images/single_product_example.png",
                      productPrice: 5.99),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: NewProductItem(
                      productName: "Original Blend",
                      productShortDescription:
                          "Organic Paws Kangaroo Recipe offers a natural, balanced meal for cats and dogs of all ages.",
                      productImage: "assets/images/single_product_example.png",
                      productPrice: 5.99),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: NewProductItem(
                      productName: "Original Blend",
                      productShortDescription:
                          "Organic Paws Kangaroo Recipe offers a natural, balanced meal for cats and dogs of all ages.",
                      productImage: "assets/images/single_product_example.png",
                      productPrice: 5.99),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

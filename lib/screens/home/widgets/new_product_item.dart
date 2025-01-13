// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class NewProductItem extends StatelessWidget {
  final String productName;
  final String productShortDescription;
  final String productImage;
  final double productPrice;

  const NewProductItem(
      {super.key,
      required this.productName,
      required this.productShortDescription,
      required this.productImage,
      required this.productPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color.fromARGB(255, 255, 255, 255),
      ),
      margin: const EdgeInsets.only(right: 6),
      padding: const EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: 225,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(productImage),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            productName,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Signika Bold',
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: 200,
            child: Text(
              productShortDescription,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Signika Regular',
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            '\$${productPrice.toString()}',
            style: const TextStyle(
              fontSize: 20,
              fontFamily: 'Signika Medium',
            ),
          ),
        ],
      ),
    );
  }
}

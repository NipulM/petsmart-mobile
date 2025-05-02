// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cb011999/screens/product/single_product_screen.dart';
import 'package:cb011999/widgets/button.dart';
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isDarkMode ? Color(0xFF2C2C2C) : Colors.white,
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
                image: NetworkImage(productImage),
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
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Roboto Bold',
              color: isDarkMode
                  ? Colors.white.withOpacity(0.87)
                  : Colors.black.withOpacity(0.87),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: 225,
            child: Text(
              productShortDescription,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Roboto Regular',
                color: isDarkMode
                    ? Colors.white.withOpacity(0.87)
                    : Colors.black.withOpacity(0.87),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: 225, // Match the image width
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 80, // Fixed width for price section
                  child: Text(
                    '\$${productPrice.toString()}',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Roboto Medium',
                      color: isDarkMode
                          ? Colors.white.withOpacity(0.87)
                          : Colors.black.withOpacity(0.87),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 36,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          textStyle: Theme.of(context).textTheme.labelLarge,
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Item added to cart'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                        child: Text('Add to cart'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

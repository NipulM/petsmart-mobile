// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cb011999/screens/about/widgets/image_container.dart';
import 'package:flutter/material.dart';

class HeroContainer extends StatelessWidget {
  const HeroContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("About Us",
              style: const TextStyle(
                fontSize: 24,
                fontFamily: 'Roboto Regular',
              )),
          SizedBox(
            height: 15,
          ),
          ImageContainer(imageUrl: "assets/images/about_us_1.png"),
          SizedBox(
            height: 20,
          ),
          Text(
            "At PetSmart, we believe in making the world a better place—one paw at a time. As pet lovers ourselves, we understand the joy and responsibility of caring for your furry, feathery, or scaly companions. That's why we created an e-commerce platform dedicated to providing high-quality, eco-friendly, and sustainable pet products that both you and your pets will love.",
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Roboto Regular',
            ),
          ),
        ],
      ),
    );
  }
}

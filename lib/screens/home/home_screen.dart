// ignore_for_file: prefer_const_constructors
import 'package:cb011999/screens/home/widgets/hero_section.dart';
import 'package:cb011999/screens/home/widgets/new_arrivals_section.dart';
import 'package:cb011999/screens/home/widgets/subscription_section.dart';

import 'package:cb011999/widgets/footer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          HeroSection(
            title: "Your One-Stop Shop for Pet Essentials",
            description:
                "Find everything your pet loves in one place—delivered to your door. From premium food to stylish toys and accessories, PetSmart brings convenience and quality together for your furry friends.",
          ),
          SizedBox(
            height: 10,
          ),
          NewArrivalsSection(
            title: "New Arrivals for Your Beloved Pets",
            description:
                "Check out the latest additions to our collection! From delicious treats to fun toys, these fresh picks are here to delight your pets and make life easier for you.",
          ),
          SubscriptionSection(
            title: "Simplify Pet Care with Tailored Subscription Plans",
            description:
                "Say goodbye to the stress of running out of pet essentials. With PetSmart's flexible subscription plans, you'll get regular deliveries tailored to your needs—keeping your pets happy, healthy, and entertained all year round.",
          ),
          Footer()
        ],
      ),
    );
  }
}

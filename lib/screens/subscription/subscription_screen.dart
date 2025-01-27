// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cb011999/screens/subscription/widgets/hero_section.dart';
import 'package:cb011999/screens/subscription/widgets/subscription_card.dart';
import 'package:cb011999/widgets/button.dart';
import 'package:cb011999/widgets/footer.dart';
import 'package:flutter/material.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HeroSection(
                title: "Subscribe to Simplify Your Pet Care!",
                description:
                    "Say goodbye to the stress of last-minute shopping for your pet's needs. With PetSmart's subscription plans, you'll enjoy seamless, regular deliveries tailored to your pet's lifestyle—ensuring happiness, health, and convenience every step of the way.",
                imageUrl: "assets/images/subscription_hero.jpg"),
            SubscriptionCard(
                title: "Basic",
                imageUrl: "assets/images/subscription_plan_example.jpg",
                description:
                    "Enjoy hassle-free pet care with a 3-month subscription. Customize your supplies and receive regular deliveries to your door.",
                features: [
                  "Flexible supply updates anytime.",
                  "Monthly toy replacement to keep your pet entertained.",
                  "Perfect for pet parents seeking convenience and reliability."
                ],
                price: 19.99,
                shortDescription: "3 months of hassle-free pet care!"),
            SubscriptionCard(
                title: "Premium",
                imageUrl: "assets/images/subscription_plan_example.jpg",
                description:
                    "Simplify your pet care for an entire year with our Premium Plan. Fully managed supplies and monthly surprises!",
                features: [
                  "All benefits of the Basic Plan.",
                  "Exclusive premium items included.",
                  "Exclusive discounts on pet essentials and add-ons."
                ],
                price: 49.99,
                shortDescription: "1 year of premium pet care!"),
            Footer()
          ],
        ),
      ),
    );
  }
}

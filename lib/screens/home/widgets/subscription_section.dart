// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cb011999/screens/home/widgets/subscription_card.dart';
import 'package:flutter/material.dart';
import 'package:cb011999/screens/home/widgets/hero_section.dart';

class SubscriptionSection extends StatelessWidget {
  final String title;
  final String description;

  const SubscriptionSection(
      {super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeroSection(title: title, description: description),
          SubscriptionCard(
              title: "Basic",
              imageUrl: "assets/images/subscription_plan_example.jpg",
              description:
                  "Enjoy hassle-free pet care with a 3-month subscription. Customize your supplies and receive regular deliveries to your door.",
              features: [
                "Flexible supply updates anytime.",
                "Monthly toy replacement to keep your pet entertained.",
              ]),
          SubscriptionCard(
              title: "Premium",
              imageUrl: "assets/images/subscription_plan_example.jpg",
              description:
                  "Simplify your pet care for an entire year with our Premium Plan. Fully managed supplies and monthly surprises!",
              features: [
                "All benefits of the Basic Plan.",
                "Exclusive premium items included.",
              ]),
        ],
      ),
    );
  }
}

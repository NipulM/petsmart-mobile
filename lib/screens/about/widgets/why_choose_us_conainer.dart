// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cb011999/screens/about/widgets/image_container.dart';
import 'package:flutter/material.dart';

class WhyChooseUsConainer extends StatelessWidget {
  static List<String> whyChooseUsList = [
    "Eco-Friendly Products: From non-toxic toys to biodegradable pet care essentials, we prioritise sustainability in everything we offer.",
    "Convenience at Your Fingertips: No more rushing to the store—shop from the comfort of your home and have everything delivered right to your door.",
    "Tailored Monthly Subscriptions: Our Monthly Box is customised to suit your pet's unique needs, bringing joy and surprises every month.",
    "Educational Resources: Stay informed with our blogs and videos on pet care, sustainable living, and DIY tips to make your pet's life even better."
  ];

  const WhyChooseUsConainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Why Choose Us?",
              style: const TextStyle(
                fontSize: 24,
                fontFamily: 'Roboto Regular',
              )),
          SizedBox(height: 15),
          Text(
            "We know you have options when it comes to shopping for your pets, but here's what sets us apart:",
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Roboto Regular',
            ),
          ),
          SizedBox(height: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: whyChooseUsList
                .map((feature) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("•",
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Roboto Regular',
                              )),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              feature,
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Roboto Regular',
                              ),
                            ),
                          )
                        ],
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

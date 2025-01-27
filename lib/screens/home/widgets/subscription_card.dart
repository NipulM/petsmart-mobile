// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cb011999/widgets/button.dart';
import 'package:flutter/material.dart';

class SubscriptionCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;
  final List<String> features;

  const SubscriptionCard(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.description,
      required this.features});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 255, 255, 255),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 175,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontFamily: 'Roboto Bold',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Roboto Regular',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: features
                .map((feature) => Row(children: [
                      Icon(
                        Icons.check,
                        size: 20,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10, top: 8),
                        width: 300,
                        child: Text(
                          feature,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Roboto Regular',
                          ),
                        ),
                      )
                    ]))
                .toList(),
          ),
          SizedBox(
            height: 20,
          ),
          Button(buttonText: "Subscribe to ${title}"),
        ],
      ),
    );
  }
}

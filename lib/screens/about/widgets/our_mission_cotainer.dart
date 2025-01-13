// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cb011999/screens/about/widgets/image_container.dart';
import 'package:flutter/material.dart';

class OurMissionConatiner extends StatelessWidget {
  static List<String> missions = [
    "To provide pet owners with sustainable and ethical choices.",
    "To support a healthier planet by reducing waste and promoting environmentally friendly practices.",
    "To ensure every pet gets the care, comfort, and love they deserve."
  ];

  const OurMissionConatiner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Our Mission",
              style: const TextStyle(
                fontSize: 24,
                fontFamily: 'Signika Regular',
              )),
          SizedBox(
            height: 15,
          ),
          ImageContainer(imageUrl: "assets/images/about_us_2.png"),
          SizedBox(
            height: 20,
          ),
          Text(
            "Our Mission is simple:",
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Signika Regular',
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: missions
                .map((feature) => Row(children: [
                      Text("•",
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Signika Regular',
                          )),
                      Container(
                        margin: const EdgeInsets.only(left: 10, top: 8),
                        width: 350,
                        child: Text(
                          feature,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Signika Regular',
                          ),
                        ),
                      )
                    ]))
                .toList(),
          ),
        ],
      ),
    );
  }
}

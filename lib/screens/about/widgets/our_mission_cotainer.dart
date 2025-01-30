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
    final orientation = MediaQuery.of(context).orientation;

    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Our Mission",
              style: const TextStyle(
                fontSize: 24,
                fontFamily: 'Roboto Regular',
              )),
          SizedBox(
            height: 15,
          ),
          if (orientation == Orientation.landscape)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 55,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: missions
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
                ),
                SizedBox(width: 20),
                Flexible(
                  flex: 45,
                  child: ImageContainer(
                    imageUrl: "assets/images/about_us_2.png",
                  ),
                ),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageContainer(imageUrl: "assets/images/about_us_2.png"),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: missions
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
        ],
      ),
    );
  }
}

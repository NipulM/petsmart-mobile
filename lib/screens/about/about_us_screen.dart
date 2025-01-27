// ignore_for_file: prefer_const_constructors
import 'package:cb011999/screens/about/widgets/blog_container.dart';
import 'package:cb011999/screens/about/widgets/hero_container.dart';
import 'package:cb011999/screens/about/widgets/image_container.dart';
import 'package:cb011999/screens/about/widgets/our_mission_cotainer.dart';
import 'package:cb011999/screens/about/widgets/why_choose_us_conainer.dart';
import 'package:cb011999/widgets/footer.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Align(
            alignment: Alignment.center,
            child: Text("Welcome to PetSmart!",
                style: TextStyle(
                  fontSize: 28,
                  fontFamily: 'Roboto Medium',
                )),
          ),
          SizedBox(
            height: 10,
          ),
          HeroContainer(),
          OurMissionConatiner(),
          WhyChooseUsConainer(),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text(
                    "Looking for tips on pet grooming, training, or sustainable living? Check out our blog, where we share weekly articles and videos to help you care for your pets with love and knowledge.",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto Regular',
                    )),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "Thank you for being part of the PetSmart community—where happy pets meet a healthier planet! ❤️",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto Regular',
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Care & Comfort Corner",
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Roboto Bold',
                  )),
            ),
          ),
          BlogContainer(
              title: "5 Easy Grooming Tips for a Happier Pet",
              description:
                  "Keeping your pet clean and well-groomed is essential for their health and happiness. From regular brushing to choosing the right shampoo, small efforts can make a big difference. Whether you're a seasoned pet parent or a newbie, these quick grooming tips will have your furry friend looking and feeling their best in no time!",
              imageUrl: "assets/images/blog_example.jpg"),
          Footer()
        ],
      ),
    );
  }
}

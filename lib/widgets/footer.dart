// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 20, top: 30),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFF6DBF73),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Quick Links",
              style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 24,
                fontFamily: "Roboto Medium",
              )),
          SizedBox(
            height: 10,
          ),
          Text(
            "• Home",
            style: TextStyle(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: 16,
              fontFamily: "Roboto Regular",
            ),
          ),
          Text(
            "• Search",
            style: TextStyle(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: 16,
              fontFamily: "Roboto Regular",
            ),
          ),
          Text(
            "• Subscriptions",
            style: TextStyle(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: 16,
              fontFamily: "Roboto Regular",
            ),
          ),
          Text(
            "• About Us",
            style: TextStyle(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: 16,
              fontFamily: "Roboto Regular",
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Text("Contact Information",
              style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 24,
                fontFamily: "Roboto Medium",
              )),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Icon(
                Icons.alternate_email,
                color: Colors.black,
              ),
              SizedBox(
                width: 10,
              ),
              Text("support@petsmart.com",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 16,
                    fontFamily: "Roboto Regular",
                  ))
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Icon(
                Icons.phone_in_talk_outlined,
                color: Colors.black,
              ),
              SizedBox(
                width: 10,
              ),
              Text("+94 77 071 4178",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 16,
                    fontFamily: "Roboto Regular",
                  ))
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: Colors.black,
              ),
              SizedBox(
                width: 10,
              ),
              Text("134/89, Kindamith Str. Ppers Rd.",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 16,
                    fontFamily: "Roboto Regular",
                  ))
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Center(
            child: Text(
              "© 2024 PetSmart. All rights reserved.",
              style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 16,
                fontFamily: "Roboto Medium",
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

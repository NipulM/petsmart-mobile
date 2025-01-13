import 'package:cb011999/screens/about/about_us_screen.dart';
import 'package:cb011999/screens/home/home_screen.dart';
import 'package:cb011999/screens/product/single_product_screen.dart';
import 'package:cb011999/screens/subscription/subscription_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const SingleProductScreen(),
      // home: const HomeScreen(),
      // home: const AboutUsScreen(),
      home: const SubscriptionScreen(),
    );
  }
}

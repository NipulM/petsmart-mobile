// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cb011999/widgets/button.dart';
import 'package:flutter/material.dart';

class SubscriptionCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;
  final List<String> features;

  const SubscriptionCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    // Get the current theme brightness
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isDarkMode ? Color(0xFF2C2C2C) : Colors.white,
        // Add subtle shadow based on theme
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
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
          SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Roboto Bold',
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Roboto Regular',
              color: isDarkMode
                  ? Colors.white.withOpacity(0.87)
                  : Colors.black.withOpacity(0.87),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: features
                .map((feature) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.check,
                            size: 20,
                            color: isDarkMode
                                ? Color(0xFF6DBF73) // Green icon in dark mode
                                : Color(
                                    0xFF6DBF73), // Keep same green in light mode
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              feature,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Roboto Regular',
                                color: isDarkMode
                                    ? Colors.white.withOpacity(0.87)
                                    : Colors.black.withOpacity(0.87),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
          SizedBox(height: 20),
          Button(buttonText: "Subscribe to $title"),
        ],
      ),
    );
  }
}

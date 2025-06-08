import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;

  const Button({
    super.key, 
    required this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48, // Standard button height
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          textStyle: Theme.of(context).textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed ?? () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please contact our support team (support@petsmart.com) to place a subscription. Thank you!'),
              duration: Duration(seconds: 10),
            ),
          );
        },
        child: Text(buttonText),
      ),
    );
  }
}

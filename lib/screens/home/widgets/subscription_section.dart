// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cb011999/models/subscription.dart';
import 'package:cb011999/screens/home/widgets/subscription_card.dart';
import 'package:cb011999/services/subscription_service.dart';
import 'package:flutter/material.dart';
import 'package:cb011999/screens/home/widgets/hero_section.dart';

class SubscriptionSection extends StatefulWidget {
  final String title;
  final String description;

  const SubscriptionSection({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  State<SubscriptionSection> createState() => _SubscriptionSectionState();
}

class _SubscriptionSectionState extends State<SubscriptionSection> {
  final SubscriptionService _subscriptionService = SubscriptionService();
  List<Subscription> _subscriptions = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadSubscriptions();
  }

  Future<void> _loadSubscriptions() async {
    try {
      final subscriptions = await _subscriptionService.getAllSubscriptions();
      setState(() {
        _subscriptions = subscriptions;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
      print('Error loading subscriptions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeroSection(title: widget.title, description: widget.description),
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else if (_error != null)
            Center(
              child: SizedBox(
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.grey,
                      size: 40,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Failed to load subscription plans.\nPlease check your connection and try again.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else if (_subscriptions.isEmpty)
            const Center(
              child: Text('No subscription plans available'),
            )
          else
            ..._subscriptions.map((subscription) => SubscriptionCard(
                  title: subscription.planType,
                  imageUrl: "assets/images/subscription_plan_example.jpg",
                  description: subscription.description,
                  features: subscription.features.map((e) => e.toString().trim()).toList(),
                )).toList(),
        ],
      ),
    );
  }
}

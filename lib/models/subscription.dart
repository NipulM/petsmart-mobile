class Subscription {
  final String? id; // MongoDB document ID
  final String subscriptionId;
  final String planType;
  final String description;
  final double price;
  final List<dynamic> features;

  Subscription({
    this.id,
    required this.subscriptionId,
    required this.planType,
    required this.description,
    required this.price,
    required this.features,
  });

  // Convert Subscription instance to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'subscription_id': subscriptionId,
      'plan_type': planType,
      'description': description,
      'price': price,
      'features': features,
    };
  }

  // Create Subscription instance from JSON
  factory Subscription.fromJson(Map<String, dynamic> json) {
    // Handle price conversion from either String or num
    double parsePrice(dynamic price) {
      if (price is num) {
        return price.toDouble();
      } else if (price is String) {
        return double.parse(price);
      }
      throw FormatException('Invalid price format');
    }

    List<String> parseFeatures(dynamic features) {
      if (features is List) {
        return features.map((e) {
          String feature = e.toString();
          // Remove any quotes and square brackets
          feature = feature.replaceAll('"', '').replaceAll('[', '').replaceAll(']', '').trim();
          return feature;
        }).toList();
      } else if (features is String) {
        String feature = features.toString();
        feature = feature.replaceAll('"', '').replaceAll('[', '').replaceAll(']', '').trim();
        return [feature];
      }
      return [];
    }

    return Subscription(
      id: json['_id']?.toString(),
      subscriptionId: (json['subscription_id'] ?? '').toString(),
      planType: (json['plan_type'] ?? '').toString(),
      description: json['description'] ?? '',
      price: parsePrice(json['price'] ?? 0),
      features: parseFeatures(json['features']),
    );
  }
}

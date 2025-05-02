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

    // Handle features conversion from either String or List
    List<String> parseFeatures(dynamic features) {
      if (features is List) {
        return features.map((e) => e.toString()).toList();
      } else if (features is String) {
        // If it's a single string, return it as a single-item list
        return [features];
      }
      return []; // Return empty list if features is null or invalid
    }

    return Subscription(
      id: json['_id']?.toString(),
      subscriptionId: json['subscription_id'],
      planType: json['plan_type'],
      description: json['description'],
      price: parsePrice(json['price']),
      features: parseFeatures(json['features']),
    );
  }
}

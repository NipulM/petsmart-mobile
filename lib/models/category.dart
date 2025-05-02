class Category {
  final String? id;
  final String categoryId;
  final String name;
  final String description;

  Category({
    this.id,
    required this.categoryId,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'category_id': categoryId,
      'name': name,
      'description': description,
    };
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['category_id'],
      name: json['name'],
      description: json['description'],
    );
  }
}



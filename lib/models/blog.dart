class Blog {
  final String? id; // MongoDB document ID
  final int blogId;
  final String title;
  final String content;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  Blog({
    this.id,
    required this.blogId,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'blog_id': blogId,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['_id']?.toString(),
      blogId: json['blog_id'],
      title: json['title'],
      content: json['content'],
      imageUrl: json['image_url'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}


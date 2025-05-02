class Blog {
  final String? id; // MongoDB document ID
  final String blogId;
  final String title;
  final String content;
  final String imageUrl;
  final String createdAt;

  Blog({
    this.id,
    required this.blogId,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.createdAt,
  });


  Map<String, dynamic> toJson() {
    return {
      'blog_id': blogId,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'created_at': createdAt,
    };
  }

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['_id']?.toString(),
      blogId: json['blog_id'],
      title: json['title'],
      content: json['content'],
      imageUrl: json['image_url'],
      createdAt: json['created_at'],
    );
  }
}


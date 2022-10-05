class Post {
  final String id;
  final String title;
  final String body;

  const Post({required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(id: json['id'], title: json['title'], body: json['body']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }

  Post copyWith({String? title, String? body}) {
    return Post(id: id, title: title ?? this.title, body: body ?? this.body);
  }
}

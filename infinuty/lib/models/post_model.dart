class Post {
  final int id;
  final String url;
  final String title;
  final String description;
  final int authorId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Author author;

  Post({
    required this.id,
    required this.url,
    required this.title,
    required this.description,
    required this.authorId,
    required this.createdAt,
    required this.updatedAt,
    required this.author,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      url: json['url'],
      title: json['title'],
      description: json['description'],
      authorId: json['authorId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      author: Author.fromJson(json['author']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'title': title,
      'description': description,
      'authorId': authorId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'author': author.toJson(),
    };
  }
}

class Author {
  final int id;
  final String profilePic;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  Author({
    required this.id,
    required this.profilePic,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'],
      profilePic: json['profilePic'],
      name: json['name'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profilePic': profilePic,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

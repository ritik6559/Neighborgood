import 'package:neighborgood/models/comments.dart';

class Post {
  final String id;
  final String uid;
  final String authorName;
  final String authorImage;
  final String title;
  final String description;
  final String image;
  final DateTime createdAt;
  final List<String> likedBy;
  final List<String> savedBy;
  final List<Comment> comments;

  Post({
    required this.id,
    required this.uid,
    required this.authorName,
    required this.authorImage,
    required this.title,
    required this.description,
    required this.image,
    required this.createdAt,
    required this.likedBy,
    required this.savedBy,
    required this.comments,
  });

  Post copyWith({
    String? id,
    String? uid,
    String? authorName,
    String? authorImage,
    String? title,
    String? description,
    String? image,
    DateTime? createdAt,
    List<String>? likedBy,
    List<String>? savedBy,
    List<Comment>? comments,
  }) {
    return Post(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      authorName: authorName ?? this.authorName,
      authorImage: authorImage ?? this.authorImage,
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      likedBy: likedBy ?? this.likedBy,
      savedBy: savedBy ?? this.savedBy,
      comments: comments ?? this.comments,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'authorName': authorName,
      'authorImage': authorImage,
      'title': title,
      'description': description,
      'image': image,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'likedBy': likedBy,
      'savedBy': savedBy,
      'comments': comments.map((x) => x.toMap()).toList(),
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] ?? '',
      uid: map['uid'] ?? '',
      authorName: map['authorName'] ?? '',
      authorImage: map['authorImage'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      likedBy: List<String>.from(map['likedBy']),
      savedBy: List<String>.from(map['savedBy']),
      comments: List<Comment>.from(map['comments']?.map((x) => Comment.fromMap(x))),
    );
  }
}

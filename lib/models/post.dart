import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:neighborgood/models/comments.dart';

class Post {
  final String id;
  final String uid;
  final String authorName;
  final String authorImage;
  final String authorDescription;
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
    required this.authorDescription,
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
    String? authorDescription,
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
      authorDescription: authorDescription ?? this.authorDescription,
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
      'authorDescription': authorDescription,
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
      authorDescription: map['authorDescription'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      likedBy: List<String>.from(map['likedBy']),
      savedBy: List<String>.from(map['savedBy']),
      comments: List<Comment>.from(map['comments']?.map((x) => Comment.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Post(id: $id, uid: $uid, authorName: $authorName, authorImage: $authorImage, authorDescription: $authorDescription, description: $description, image: $image, createdAt: $createdAt, likedBy: $likedBy, savedBy: $savedBy, comments: $comments)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Post &&
      other.id == id &&
      other.uid == uid &&
      other.authorName == authorName &&
      other.authorImage == authorImage &&
      other.authorDescription == authorDescription &&
      other.description == description &&
      other.image == image &&
      other.createdAt == createdAt &&
      listEquals(other.likedBy, likedBy) &&
      listEquals(other.savedBy, savedBy) &&
      listEquals(other.comments, comments);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      uid.hashCode ^
      authorName.hashCode ^
      authorImage.hashCode ^
      authorDescription.hashCode ^
      description.hashCode ^
      image.hashCode ^
      createdAt.hashCode ^
      likedBy.hashCode ^
      savedBy.hashCode ^
      comments.hashCode;
  }
}

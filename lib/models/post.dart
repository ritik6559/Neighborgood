import 'dart:convert';

class Post {
  final String id;
  final String uid;
  final String authorName;
  final String authorImage;
  final String authorDescription;
  final String description;
  final String image;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.uid,
    required this.authorName,
    required this.authorImage,
    required this.authorDescription,
    required this.description,
    required this.image,
    required this.createdAt,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Post(id: $id, uid: $uid, authorName: $authorName, authorImage: $authorImage, authorDescription: $authorDescription, description: $description, image: $image, createdAt: $createdAt)';
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
      other.createdAt == createdAt;
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
      createdAt.hashCode;
  }
}

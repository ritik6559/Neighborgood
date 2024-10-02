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
    );
  }
}

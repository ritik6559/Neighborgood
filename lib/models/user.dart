import 'package:neighborgood/models/post.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String description;
  final List<UserModel> followers;
  final List<Post> posts;
  final List<UserModel> following;
  final String profilePic;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.description,
    required this.followers,
    required this.posts,
    required this.following,
    required this.profilePic,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? description,
    List<UserModel>? followers,
    List<Post>? posts,
    List<UserModel>? following,
    String? profilePic,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      description: description ?? this.description,
      followers: followers ?? this.followers,
      posts: posts ?? this.posts,
      following: following ?? this.following,
      profilePic: profilePic ?? this.profilePic,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'description': description,
      'followers': followers.map((x) => x.toMap()).toList(),
      'posts': posts.map((x) => x.toMap()).toList(),
      'following': following.map((x) => x.toMap()).toList(),
      'profilePic': profilePic,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      description: map['description'] ?? '',
      followers: List<UserModel>.from(map['followers']?.map((x) => UserModel.fromMap(x))),
      posts: List<Post>.from(map['posts']?.map((x) => Post.fromMap(x))),
      following: List<UserModel>.from(map['following']?.map((x) => UserModel.fromMap(x))),
      profilePic: map['profilePic'] ?? '',
    );
  }

}

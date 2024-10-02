import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:neighborgood/models/post.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final int followers;
  final List<Post> posts;
  final int following;
  final String profilePic;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.followers,
    required this.posts,
    required this.following,
    required this.profilePic,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    int? followers,
    List<Post>? posts,
    int? following,
    String? profilePic,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
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
      'followers': followers,
      'posts': posts.map((x) => x.toMap()).toList(),
      'following': following,
      'profilePic': profilePic,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      followers: map['followers']?.toInt() ?? 0,
      posts: List<Post>.from(map['posts']?.map((x) => Post.fromMap(x))),
      following: map['following']?.toInt() ?? 0,
      profilePic: map['profilePic'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(uid: $uid, name: $name, email: $email, followers: $followers, posts: $posts, following: $following, profilePic: $profilePic)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.uid == uid &&
      other.name == name &&
      other.email == email &&
      other.followers == followers &&
      listEquals(other.posts, posts) &&
      other.following == following &&
      other.profilePic == profilePic;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      name.hashCode ^
      email.hashCode ^
      followers.hashCode ^
      posts.hashCode ^
      following.hashCode ^
      profilePic.hashCode;
  }
}

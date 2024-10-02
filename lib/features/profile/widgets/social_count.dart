import 'package:flutter/material.dart';
import 'package:neighborgood/models/user.dart';

class SocialCount extends StatelessWidget {
  final UserModel user;
  const SocialCount({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text(
              user.posts.length.toString(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Posts',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              user.followers.length.toString(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Followers',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              user.following.length.toString(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Following',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

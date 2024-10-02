import 'package:flutter/material.dart';

class SocialCount extends StatelessWidget {
  const SocialCount({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text(
              '15',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
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
              '150',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
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
              '98',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
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

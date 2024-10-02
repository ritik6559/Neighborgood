import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighborgood/features/home/data/posts.dart';
import 'package:neighborgood/features/home/widgets/post_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              'assets/icons/logo.svg',
              width: 80,
              height: 35,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/bell.svg',
                  height: 24,
                  width: 24,
                ),
                const SizedBox(width: 10),
                SvgPicture.asset(
                  'assets/icons/badge.svg',
                  height: 24,
                  width: 24,
                ),
              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: posts.map((post) => PostCard(post: post)).toList(),
        ),
      ),
    );
  }
}

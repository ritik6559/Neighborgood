// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighborgood/features/create_post/screens/create_post_screen.dart';
import 'package:neighborgood/features/home/screens/home_screen.dart';
import 'package:neighborgood/features/posts/screens/posts_screen.dart';
import 'package:neighborgood/features/profile/screens/profile_screen.dart';
import 'package:neighborgood/features/search/screens/search_screen.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  List screens = const [
    HomeScreen(),
    SearchScreen(),
    CreatePostScreen(),
    PostsScreen(),
    ProfileScreen(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: screens[currentIndex],
      bottomNavigationBar: BottomAppBar(
        height: 70,
        color: Colors.white,
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  currentIndex = 0;
                });
              },
              child: currentIndex == 0
                  ? SvgPicture.asset(
                      'assets/icons/navigation/home_selected.svg',
                      height: 30,
                      width: 30,
                    )
                  : SvgPicture.asset(
                      'assets/icons/navigation/home.svg',
                      height: 30,
                      width: 30,
                    ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  currentIndex = 1;
                });
              },
              child: currentIndex == 1
                  ? SvgPicture.asset(
                      'assets/icons/navigation/search_selected.svg',
                      height: 30,
                      width: 30,
                      color: currentIndex == 1
                          ? const Color(0xFFFF6D00)
                          : Colors.grey,
                    )
                  : SvgPicture.asset(
                      'assets/icons/navigation/search.svg',
                      height: 30,
                      width: 30,
                    ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  currentIndex = 2;
                });
              },
              child: currentIndex == 2
                  ? SvgPicture.asset(
                      'assets/icons/navigation/add_post_selected.svg',
                      height: 30,
                      width: 30,
                      color: currentIndex == 2
                          ? const Color(0xFFFF6D00)
                          : Colors.grey,
                    )
                  : SvgPicture.asset(
                      'assets/icons/navigation/add_post.svg',
                      height: 30,
                      width: 30,
                    ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  currentIndex = 3;
                });
              },
              child: currentIndex == 3
                  ? SvgPicture.asset(
                      'assets/icons/navigation/posts_selected.svg',
                      height: 30,
                      width: 30,
                      color: currentIndex == 3
                          ? const Color(0xFFFF6D00)
                          : Colors.grey,
                    )
                  : SvgPicture.asset(
                      'assets/icons/navigation/posts.svg',
                      height: 30,
                      width: 30,
                    ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  currentIndex = 4;
                });
              },
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      currentIndex == 4 ? const Color(0xFFFF6D00) : Colors.grey,
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/icons/navigation/profile.jpg',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

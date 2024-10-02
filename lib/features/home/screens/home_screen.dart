import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighborgood/features/home/widgets/post_card.dart';
import 'package:neighborgood/features/posts/repository/post_repository.dart';
import 'package:neighborgood/models/post.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  final PostRepository postRepository = PostRepository();


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
      body: StreamBuilder<List<Post>>(
        stream: postRepository.postsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFFF6D00),
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No posts available',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Post post = snapshot.data![index];
              return PostCard(
                post: post,
              );
            },
          );
        },
      ),
    );
  }
}

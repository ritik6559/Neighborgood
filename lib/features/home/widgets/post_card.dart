import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighborgood/features/home/widgets/post_button.dart';
import 'package:neighborgood/features/home/widgets/post_text_field.dart';
import 'package:neighborgood/features/posts/repository/post_repository.dart';
import 'package:neighborgood/models/comments.dart';
import 'package:neighborgood/models/post.dart';
import 'package:uuid/uuid.dart';

class PostCard extends StatefulWidget {
  final Post post;
  const PostCard({
    super.key,
    required this.post,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final TextEditingController _commentController = TextEditingController();
  final PostRepository postRepository = PostRepository();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _addComment() {
    String id = const Uuid().v1();
    postRepository.addComment(
      Comment(
        id: id,
        text: _commentController.text.trim(),
        createdAt: DateTime.now(),
        postId: widget.post.id,
        username: widget.post.authorName,
        profilePic: 'assets/icons/navigation/profile.jpg',
      ),
      context,
    );
    _commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(
                      'assets/icons/navigation/profile.jpg',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.post.authorName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        widget.post.title,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  )
                ],
              ),
              SvgPicture.asset(
                'assets/icons/more_vert.svg',
                color: Colors.black,
                height: 30,
              )
            ],
          ),
          const SizedBox(height: 20),
          Text(
            widget.post.description,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              widget.post.image,
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 15),
          PostButton(post: widget.post),
          const SizedBox(height: 10),
          PostTextField(
              controller: _commentController,
              hintText: 'Add a comment...',
              iconPath: 'assets/icons/navigation/profile.jpg',
              onSubmitted: _addComment),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighborgood/features/auth/repository/auth_repository.dart';
import 'package:neighborgood/features/posts/repository/post_repository.dart';
import 'package:neighborgood/models/post.dart';
import 'package:provider/provider.dart';

class PostButton extends StatefulWidget {
  final Post post;
  const PostButton({super.key, required this.post});

  @override
  State<PostButton> createState() => _PostButtonState();
}

class _PostButtonState extends State<PostButton> {



  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, 
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          height: 300, 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Comments Section',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.post.comments.length,
                  itemBuilder: (context, index) {
                    return Text(widget.post.comments[index].text);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }




  @override
  Widget build(BuildContext context) {
    final isLiked =
        widget.post.likedBy.contains(context.read<AuthRepository>().user.uid);
    final isSaved =
        widget.post.savedBy.contains(context.read<AuthRepository>().user.uid);

    

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<PostRepository>().likePost(
                        widget.post, context.read<AuthRepository>().user.uid);
                  },
                  child: isLiked
                      ? SvgPicture.asset(
                          'assets/icons/liked.svg',
                          height: 27,
                          width: 27,
                        )
                      : SvgPicture.asset(
                          'assets/icons/like.svg',
                          height: 22,
                        ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    _showBottomSheet(context);
                  },
                  child: SvgPicture.asset(
                    'assets/icons/comments.svg',
                    height: 22,
                  ),
                ),
                const SizedBox(width: 10),
                SvgPicture.asset(
                  'assets/icons/share.svg',
                  height: 22,
                ),
              ],
            )
          ],
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            context.read<PostRepository>().savePost(widget.post, context.read<AuthRepository>().user.uid);
          },
          child: isSaved
              ? SvgPicture.asset(
                  'assets/icons/saved.svg',
                  height: 22,
          ) : SvgPicture.asset(
            'assets/icons/save.svg',
            height: 22,
          ),
        ),
      ],
    );
  }
}

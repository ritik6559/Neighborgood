import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neighborgood/features/home/widgets/custom_text.dart';
import 'package:neighborgood/features/home/widgets/post_button.dart';
import 'package:neighborgood/features/home/widgets/post_text_field.dart';
import 'package:neighborgood/models/post.dart';

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

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
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
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${widget.post.authorDescription}...',
                              style: const TextStyle(
                                fontSize: 13,
                              ),
                            ),
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () {},
                                child: const Text(
                                  'See more',
                                  style: TextStyle(
                                    color: Color(0xFF8A8A8A),
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
          CustomText(
            text: widget.post.description,
            hashtagColor: const Color(0xFF2D68FE),
            onSeeMore: () {},
            maxLength: 22,
          ),
          const SizedBox(height: 15),
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
          ),
        ],
      ),
    );
  }
}

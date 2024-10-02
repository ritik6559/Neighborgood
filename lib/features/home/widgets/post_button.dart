import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PostButton extends StatelessWidget {
  const PostButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/like.svg',
                  height: 22,
                ),
                const SizedBox(width: 10),
                SvgPicture.asset(
                  'assets/icons/comments.svg',
                  height: 22,
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
        SvgPicture.asset(
          'assets/icons/save.svg',
          height: 22,
        ),
      ],
    );
  }
}

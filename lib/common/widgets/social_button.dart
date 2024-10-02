import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialButton extends StatelessWidget {
  final String iconPath;
  final Function() onTap;
  const SocialButton({
    super.key,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFF6F6F6),
        ),
        child: Center(
          child: SvgPicture.asset(
            height: 30,
            width: 30,
            iconPath,
          ),
        ),
      ),
    );
  }
}

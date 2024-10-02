import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileButton extends StatelessWidget {
  final String text;
  final String icon;
  final Function() onTap;
  const ProfileButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                height: 20,
              ),
              const SizedBox(width: 10),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

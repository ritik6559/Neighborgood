import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color hashtagColor;
  final int maxLength;
  final VoidCallback onSeeMore;

  const CustomText({
    super.key,
    required this.text,
    this.hashtagColor = Colors.blue,
    this.maxLength = 30,
    required this.onSeeMore,
  });

  @override
  Widget build(BuildContext context) {
    final truncated = text.length > maxLength;
    final displayText = truncated ? text.substring(0, maxLength) : text;
    final displayWords = displayText.split(' ');

    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          ...displayWords.map(
            (word) {
              return TextSpan(
                text: '$word ',
                style: word.startsWith('#')
                    ? TextStyle(
                        color: hashtagColor,
                        decoration: TextDecoration.underline,
                        fontSize: 18,
                      )
                    : const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
              );
            },
          ),
          if (truncated)
            const TextSpan(
              text: ' ...',
              style: TextStyle(
                color: Color(0xFF8A8A8A),
                decoration: TextDecoration.underline,
              ),
            ),
          if (truncated)
            WidgetSpan(
              child: GestureDetector(
                onTap: onSeeMore,
                child: const Text(
                  'See more',
                  style: TextStyle(
                    color: Color(0xFF8A8A8A),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

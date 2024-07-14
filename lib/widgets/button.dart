import 'package:bandy_flutter/constants/sizes.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;

  const Button({
    super.key,
    required this.text,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext build) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: AnimatedContainer(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size14,
          ),
          duration: const Duration(microseconds: 500),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: bgColor,
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
            ),
          )),
    );
  }
}

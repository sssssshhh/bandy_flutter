import 'package:bandy_flutter/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final FaIcon icon;

  const AuthButton({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // FractionallySizedBox = Parent.sizedbox
    return FractionallySizedBox(
      widthFactor: 1, // Parent.sizedbox * 1
      child: Container(
        padding: const EdgeInsets.all(Sizes.size14),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: Sizes.size1,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 8),
            Text(
              textAlign: TextAlign.center,
              text,
            ),
          ],
        ),
      ),
    );
  }
}

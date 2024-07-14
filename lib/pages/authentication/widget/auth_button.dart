import 'package:bandy_flutter/constants/sizes.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String text;
  const AuthButton({
    super.key,
    required this.text,
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
        child: Text(
          textAlign: TextAlign.center,
          text,
        ),
      ),
    );
  }
}

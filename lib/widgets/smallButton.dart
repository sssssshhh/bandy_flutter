import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  final String text;

  const SmallButton({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext build) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        child: Text(text),
      ),
    );
  }
}

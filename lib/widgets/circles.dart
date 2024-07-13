import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  const Circle({
    super.key,
  });

  @override
  Widget build(BuildContext build) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(45),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CurrentCircle extends StatelessWidget {
  const CurrentCircle({
    super.key,
  });

  @override
  Widget build(BuildContext build) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange[300],
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      ),
    );
  }
}

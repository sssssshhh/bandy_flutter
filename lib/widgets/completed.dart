import 'package:flutter/material.dart';

class CompletedLabel extends StatelessWidget {
  const CompletedLabel({
    super.key,
  });

  @override
  Widget build(BuildContext build) {
    return Positioned(
      top: 8,
      left: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.7),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'Completed',
          style: TextStyle(
            color: Colors.red[500],
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

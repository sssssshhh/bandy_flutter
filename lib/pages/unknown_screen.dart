import 'package:flutter/material.dart';

class UnknownScreen extends StatelessWidget {
  const UnknownScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Unknown",
        ),
      ),
      body: const Center(child: Text('페이지를 찾을 수 없습니다.', style: TextStyle(fontSize: 18))),
    );
  }
}

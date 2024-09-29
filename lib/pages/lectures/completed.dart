import 'package:flutter/material.dart';

class Completed extends StatefulWidget {
  const Completed({super.key});

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 세로 정렬
          crossAxisAlignment: CrossAxisAlignment.center, // 가로 정렬
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.orange,
              size: 48, // 아이콘 크기 조절
            ),
            SizedBox(height: 16), // 아이콘과 텍스트 사이의 간격
            Text(
              "Completed",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/constants/sizes.dart';
import 'package:flutter/material.dart';

class ListenSpeak extends StatefulWidget {
  const ListenSpeak({super.key});

  @override
  State<ListenSpeak> createState() => _ListenSpeakState();
}

class _ListenSpeakState extends State<ListenSpeak> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(), // TODO: go to lecture
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size20,
          horizontal: Sizes.size40,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Listen and repeat",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 400,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // 세로 중앙 정렬
                crossAxisAlignment: CrossAxisAlignment.center, // 가로 중앙 정렬
                children: [
                  Icon(
                    Icons.headphones,
                    color: Colors.grey[400],
                    size: 48,
                  ),
                  Gaps.v16,
                  Text(
                    "Listen and repeat",
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v8,
                  Text(
                    "Listen and repeat",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[400],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Press and speak',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Gaps.v28,
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.keyboard_voice_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                Gaps.v20,
              ],
            ),
          ],
        ),
      ),
    );
  }
}

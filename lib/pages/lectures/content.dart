import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/pages/lectures/lecture.dart';
import 'package:flutter/material.dart';

class Contents extends StatefulWidget {
  final Lecture widget;

  const Contents({
    super.key,
    required this.widget,
  });

  @override
  State<Contents> createState() => _ContentsState();
}

class _ContentsState extends State<Contents> {
  bool isKorean = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(34.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Notes',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isKorean = !isKorean;
                    });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      isKorean ? 'KOR' : 'ENG',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Gaps.v10,
            Text(isKorean
                ? widget.widget.lecture['korExplanation']
                    .replaceAll(r'\n', '\n')
                : widget.widget.lecture['engExplanation']
                    .replaceAll(r'\n', '\n')),
          ],
        ),
      ),
    );
  }
}

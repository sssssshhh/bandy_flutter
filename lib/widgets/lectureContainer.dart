import 'package:bandy_flutter/pages/lectures/lecture.dart';
import 'package:bandy_flutter/pages/lectures/pronucation_assessment.dart';
import 'package:bandy_flutter/pages/lectures/puzzle.dart';
import 'package:flutter/material.dart';

class lectureContainer extends StatelessWidget {
  final String page;
  final String thumbnailPath;
  final String level;

  const lectureContainer({
    super.key,
    required this.page,
    required this.level,
    required this.thumbnailPath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (page.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => _getPage(page)),
          );
        }
      },
      child: Container(
        width: 180,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.black12,
            width: 3,
          ),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                thumbnailPath,
                fit: BoxFit.cover,
                width: 150,
                height: 100,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Level $level',
                  style: const TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _getPage(String page) {
  switch (page) {
    case 'puzzle':
      return const Puzzle(); // Example page
    case 'lecture':
      return const Lecture();
    case 'pronunciationAssessment':
      return const PronunciationAssessment(); // Example page
    // Add more cases for other pages
    default:
      return const Placeholder(); // Fallback page
  }
}

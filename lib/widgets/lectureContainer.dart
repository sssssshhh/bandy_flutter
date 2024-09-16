import 'package:bandy_flutter/pages/lectures/lecture.dart';
import 'package:bandy_flutter/pages/lectures/pronucation_assessment.dart';
import 'package:bandy_flutter/pages/lectures/puzzle.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class lectureContainer extends StatelessWidget {
  final String page;
  final String? level;
  final String thumbnailPath;

  const lectureContainer({
    super.key,
    required this.page,
    this.level,
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
        width: 130,
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
              child: CachedNetworkImage(
                imageUrl: thumbnailPath,
                fit: BoxFit.cover,
                width: 150,
                height: 100,
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
      return const Puzzle();
    case 'confused_korean':
      return const Lecture(category: 'confused_korean', level: 'level_1');
    case 'podcast':
      return const Lecture(category: 'podcast', level: 'level_1');
    case 'bitesize_story':
      return const Lecture(category: 'bitesize_story', level: 'level_1');
    case 'pronucation_assessment':
      return const PronunciationAssessment();
    default:
      return const Placeholder(); // Fallback page
  }
}

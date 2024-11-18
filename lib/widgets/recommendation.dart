import 'package:bandy_flutter/constants/bandy.dart';
import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/pages/lectures/lecture.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Recommendation extends StatefulWidget {
  final String nickname;
  final Map<String, dynamic> lecture;
  final List completedLectureList;

  const Recommendation({
    super.key,
    required this.nickname,
    required this.lecture,
    required this.completedLectureList,
  });

  @override
  State<Recommendation> createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation> {
  @override
  Widget build(BuildContext context) {
    const double recommendationWidth = 300;
    const double recommendationHeight = 200;
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 500,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFFACD),
                Colors.white,
              ],
              stops: [0.6, 0.3], // 30% 지점에서 색상 변경
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 70,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/lecture/bandy_lecture.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Gaps.h10,
                  Text(
                    'Hello ${widget.nickname}',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Gaps.v20,
              const Text(
                'Recommendation',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Recommended Courses for A1',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Gaps.v10,
              Column(
                children: [
                  Container(
                    width: recommendationWidth,
                    height: recommendationHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: Colors.white,
                        width: 4,
                      ),
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: CachedNetworkImage(
                            imageUrl: widget.lecture['thumbnailPath'],
                            fit: BoxFit.cover,
                            width: recommendationWidth,
                            height: recommendationHeight,
                          ),
                        ),
                        Positioned(
                          left: 10,
                          bottom: 5,
                          child: SizedBox(
                            width: 70,
                            height: 70,
                            child: IconButton(
                              icon: const Icon(
                                Icons.play_arrow,
                                color: Colors.black,
                                size: 50,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Lecture(
                                        category: Bandy.confusedKorean,
                                        level: 'level1',
                                        lecture: widget.lecture,
                                        lessonNo: 1,
                                        completedLectureList:
                                            widget.completedLectureList),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: recommendationWidth,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(3.0),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(
                              widget.lecture['title'],
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            const Text(
                              "In Korea, there are several folk remedies, These can be used to treat some ...",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

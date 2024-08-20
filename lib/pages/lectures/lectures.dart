import 'package:bandy_flutter/constants/fonts.dart';
import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/constants/sizes.dart';
import 'package:bandy_flutter/pages/lectures/lecture.dart';
import 'package:bandy_flutter/pages/lectures/pronucation_assessment.dart';
import 'package:bandy_flutter/pages/lectures/puzzle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Lectures extends StatefulWidget {
  const Lectures({super.key});

  @override
  State<Lectures> createState() => _LecturesState();
}

class _LecturesState extends State<Lectures> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Future<Map<String, dynamic>?> findDB() async {
  //   final doc = await _db
  //       .collection('lectures')
  //       .doc('Confused_Korean')
  //       .collection('main')
  //       .doc('1')
  //       .get();
  //   print(doc.data());
  //   return doc.data();
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          width: 500,
          height: 1000,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size28,
                  vertical: Sizes.size5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hi, Sue',
                          style: Fonts.titleLarge,
                        ),
                        Gaps.v20,
                        const Text(
                          'Recommendation',
                          style: Fonts.titleLMedium,
                        ),
                        const Text(
                          'Recommended Courses for A1',
                          style: Fonts.titleSmall,
                        ),
                        Gaps.v10,
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 50,
                              horizontal: 50,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gaps.v20,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Korean Podcast',
                          style: Fonts.titleLMedium,
                        ),
                        Gaps.v10,
                        SizedBox(
                          height: 100, // ListView의 높이 지정
                          child: ListView(
                            scrollDirection: Axis.horizontal, // 가로 스크롤 설정
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 50,
                                    horizontal: 50,
                                  ),
                                ),
                              ),
                              Gaps.h10,
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 50,
                                    horizontal: 50,
                                  ),
                                ),
                              ),
                              Gaps.h10,
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 50,
                                    horizontal: 50,
                                  ),
                                ),
                              ),
                              Gaps.h10,
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 50,
                                    horizontal: 50,
                                  ),
                                ),
                              ),
                              Gaps.h10,
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 50,
                                    horizontal: 50,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Gaps.v20,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Korean Pronunciation Test',
                          style: Fonts.titleLMedium,
                        ),
                        Gaps.v10,
                        SizedBox(
                          height: 100, // ListView의 높이 지정
                          child: ListView(
                            scrollDirection: Axis.horizontal, // 가로 스크롤 설정
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PronunciationAssessment()),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 50,
                                      horizontal: 50,
                                    ),
                                  ),
                                ),
                              ),
                              Gaps.h10,
                            ],
                          ),
                        ),
                      ],
                    ),
                    Gaps.v20,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Puzzles',
                          style: Fonts.titleLMedium,
                        ),
                        Gaps.v10,
                        SizedBox(
                          height: 100,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Puzzle()),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 50,
                                      horizontal: 50,
                                    ),
                                  ),
                                ),
                              ),
                              Gaps.h10,
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Video',
                          style: Fonts.titleLMedium,
                        ),
                        Gaps.v10,
                        SizedBox(
                          height: 100,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Lecture()),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 50,
                                      horizontal: 50,
                                    ),
                                  ),
                                ),
                              ),
                              Gaps.h10,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

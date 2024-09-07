import 'package:bandy_flutter/constants/fonts.dart';
import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/constants/sizes.dart';
import 'package:bandy_flutter/widgets/lectureContainer.dart';
import 'package:flutter/material.dart';

class Lectures extends StatefulWidget {
  const Lectures({super.key});

  @override
  State<Lectures> createState() => _LecturesState();
}

class _LecturesState extends State<Lectures> {
  // final FirebaseFirestore _db = FirebaseFirestore.instance;

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
    const String level_1 = '1';
    const String level_2 = '2';
    const String level_3 = '3';

    const String confusedKorean = 'confused_korean';
    const String podcast = 'podcast';
    const String bitesizeStory = 'bitesize_story';

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
                    Gaps.v20,
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lets Start',
                          style: Fonts.titleLarge,
                        ),
                      ],
                    ),
                    Gaps.v20,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Confused Korean',
                          style: Fonts.titleLMedium,
                        ),
                        Gaps.v10,
                        SizedBox(
                          height: 150,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: const [
                              Column(
                                children: [
                                  lectureContainer(
                                    page: confusedKorean,
                                    level: level_1,
                                    thumbnailPath:
                                        'https://bandy-contents.s3.ap-northeast-1.amazonaws.com/confused_korean/level_1/thumbnail/lv1_1.png',
                                  ),
                                  Gaps.h5,
                                  Text('Level $level_1'),
                                ],
                              ),
                              Gaps.h10,
                              Column(
                                children: [
                                  lectureContainer(
                                    page: confusedKorean,
                                    level: level_2,
                                    thumbnailPath:
                                        'https://bandy-contents.s3.ap-northeast-1.amazonaws.com/confused_korean/level_2/thumbnail/lv2_1.png',
                                  ),
                                  Gaps.h5,
                                  Text('Level $level_2'),
                                ],
                              ),
                              Gaps.h5,
                              Gaps.h10,
                              Column(
                                children: [
                                  lectureContainer(
                                    page: confusedKorean,
                                    level: level_3,
                                    thumbnailPath:
                                        'https://bandy-contents.s3.ap-northeast-1.amazonaws.com/confused_korean/level_3/thumbnail/lv3_1.png',
                                  ),
                                  Gaps.h5,
                                  Text('Level $level_3'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          'PodCast',
                          style: Fonts.titleLMedium,
                        ),
                        Gaps.v10,
                        SizedBox(
                          height: 120,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: const [
                              Column(
                                children: [
                                  lectureContainer(
                                    page: podcast,
                                    level: level_1,
                                    thumbnailPath:
                                        'https://bandy-contents.s3.ap-northeast-1.amazonaws.com/podcast/level_1/thumbnail/lv1_1.png',
                                  ),
                                  Gaps.h5,
                                  Text('Level $level_1'),
                                ],
                              ),
                              Gaps.h10,
                              Column(
                                children: [
                                  lectureContainer(
                                    page: podcast,
                                    level: level_2,
                                    thumbnailPath:
                                        'https://bandy-contents.s3.ap-northeast-1.amazonaws.com/podcast/level_2/thumbnail/lv2_1.png',
                                  ),
                                  Gaps.h5,
                                  Text('Level $level_2'),
                                ],
                              ),
                              Gaps.h10,
                              Column(
                                children: [
                                  lectureContainer(
                                    page: podcast,
                                    level: level_3,
                                    thumbnailPath:
                                        'https://bandy-contents.s3.ap-northeast-1.amazonaws.com/podcast/level_3/thumbnail/lv3_1.png',
                                  ),
                                  Gaps.h5,
                                  Text('Level $level_3'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          'Bitesize Story',
                          style: Fonts.titleLMedium,
                        ),
                        Gaps.v10,
                        SizedBox(
                          height: 150,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: const [
                              Column(
                                children: [
                                  lectureContainer(
                                    page: bitesizeStory,
                                    level: level_1,
                                    thumbnailPath:
                                        'https://bandy-contents.s3.ap-northeast-1.amazonaws.com/bitesize_story/level_1/thumbnail/lv1_1.png',
                                  ),
                                  Gaps.h5,
                                  Text('Level $level_1'),
                                ],
                              ),
                              Gaps.h10,
                              Column(
                                children: [
                                  lectureContainer(
                                    page: bitesizeStory,
                                    level: level_2,
                                    thumbnailPath:
                                        'https://bandy-contents.s3.ap-northeast-1.amazonaws.com/bitesize_story/level_2/thumbnail/lv2_1.png',
                                  ),
                                  Gaps.h5,
                                  Text('Level $level_2'),
                                ],
                              ),
                              Gaps.h10,
                              Column(
                                children: [
                                  lectureContainer(
                                    page: bitesizeStory,
                                    level: level_3,
                                    thumbnailPath:
                                        'https://bandy-contents.s3.ap-northeast-1.amazonaws.com/bitesize_story/level_3/thumbnail/lv3_1.png',
                                  ),
                                  Gaps.h5,
                                  Text('Level $level_3'),
                                ],
                              ),
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

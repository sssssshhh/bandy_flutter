import 'package:bandy_flutter/constants/fonts.dart';
import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/constants/sizes.dart';
import 'package:bandy_flutter/widgets/lectureContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
                          height: 100,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: const [
                              lectureContainer(
                                page: 'puzzle',
                                level: '1',
                                thumbnailPath:
                                    'https://bandy-contents.s3.ap-northeast-1.amazonaws.com/confused_korean/level_1/thumbnail/confused_lv1_1.png',
                              ),
                              Gaps.h10,
                              lectureContainer(
                                page: 'puzzle',
                                level: '2',
                                thumbnailPath:
                                    'https://bandy-contents.s3.ap-northeast-1.amazonaws.com/confused_korean/level_2/thumbnail/confused_lv2_1.png',
                              ),
                              Gaps.h10,
                              lectureContainer(
                                page: 'puzzle',
                                level: '3',
                                thumbnailPath:
                                    'https://bandy-contents.s3.ap-northeast-1.amazonaws.com/confused_korean/level_3/thumbnail/confused_lv3_1.png',
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

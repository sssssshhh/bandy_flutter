import 'package:bandy_flutter/constants/bandy.dart';
import 'package:bandy_flutter/constants/cloudFrontPath.dart';
import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/pages/lectures/lecture.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Recommendation extends StatelessWidget {
  const Recommendation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const double recommendationWidth = 300;
    const double recommendationHeight = 200;
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 1000,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFFACD),
                Colors.white,
              ],
              stops: [0.3, 0.3], // 30% 지점에서 색상 변경
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 70,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/lecture/bandy_lecture.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Gaps.h10,
                  const Text(
                    "Let's Start",
                    style: TextStyle(
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
                        color: Colors.black12,
                        width: 3,
                      ),
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: CachedNetworkImage(
                            imageUrl:
                                '${Cloudfrontpath.Domain}/${Bandy.confusedKorean}/level_1/thumbnail/lv1_1.png',
                            fit: BoxFit.cover,
                            width: recommendationWidth,
                            height: recommendationHeight,
                          ),
                        ),
                        Positioned(
                          left: 10, // 이미지 왼쪽에서 10px 위치
                          bottom: 10, // 이미지 아래에서 10px 위치
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5), // 반투명 배경
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Lecture(
                                          category: 'confused_korean',
                                          level: 'level_1')),
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
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            // Confused lev1-1
                            Text(
                              "단모음 ㅓ, ㅕ의 발음 (ㅗ, ㅛ 단어 비교) ",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            Text(
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

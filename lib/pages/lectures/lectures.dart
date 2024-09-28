import 'dart:convert';
import 'package:bandy_flutter/constants/bandy.dart';
import 'package:bandy_flutter/constants/fonts.dart';
import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/widgets/recommendation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Lectures extends StatefulWidget {
  const Lectures({super.key});

  @override
  State<Lectures> createState() => _LecturesState();
}

class _LecturesState extends State<Lectures> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Map<String, dynamic>> podcasts = [];
  List<Map<String, dynamic>> confusedKoreans = [];
  List<Map<String, dynamic>> bitesizeStories = [];
  bool isLoading = true;

  Future<void> setBitesizeStory() async {
    final dbs = await _db
        .collection('lectures')
        .doc(Bandy.bitesizeStory)
        .collection('level1')
        .get();

    setState(() {
      bitesizeStories = dbs.docs.map((doc) => doc.data()).toList();
    });
  }

  Future<void> setPodcast() async {
    final dbs = await _db
        .collection('lectures')
        .doc(Bandy.podcast)
        .collection('level1')
        .get();

    setState(() {
      podcasts = dbs.docs.map((doc) => doc.data()).toList();
    });
  }

  Future<void> setConfusedKorean() async {
    final dbs = await _db
        .collection('lectures')
        .doc(Bandy.confusedKorean)
        .collection('level1')
        .get();

    setState(() {
      confusedKoreans = dbs.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    loadAllLectures();
  }

  Future<void> loadAllLectures() async {
    // 명시적으로 Future<void>의 리스트로 선언
    await Future.wait<void>([
      setPodcast(),
      setConfusedKorean(),
      setBitesizeStory(),
    ]);

    setState(() {
      isLoading = false; // 데이터 로드가 완료되면 로딩 상태를 false로 설정
    });
  }

  // Future<List<dynamic>> loadLectures(String category) async {
  //   final String response =
  //       await rootBundle.loadString('assets/text/data.json');
  //   final data = await json.decode(response);
  //   return data[category] ?? [];
  // }

  // Future<String?> getUserInfo() async {
  //   final User? user = _auth.currentUser;

  //   if (user != null) {
  //     print(user.email);
  //     return user.email;
  //   } else {
  //     return null;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Recommendation(),
                    clips(podcasts, Bandy.podcast),
                    clips(confusedKoreans, Bandy.confusedKorean),
                    clips(bitesizeStories, Bandy.bitesizeStory),
                  ]),
            ),
    );
  }

  Padding clips(List<Map<String, dynamic>> lectureList, String category) {
    IconData icon;
    String title;

    switch (category) {
      case 'podcast':
        icon = Icons.mic;
        title = 'Korean Podcast';
        break;
      case 'confused_korean':
        icon = Icons.search;
        title = 'Confused Korean';
        break;
      case 'bitesize_story':
        icon = Icons.menu_book_sharp;
        title = 'Bitesize Story';
        break;
      default:
        icon = Icons.error;
        title = 'Unknown Category';
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Column(
        children: [
          // 타이틀 영역
          Row(
            children: [
              IconButton(
                icon: Icon(icon, color: Colors.black),
                onPressed: () {},
              ),
              Text(
                title,
                style: Fonts.titleLMedium,
              ),
            ],
          ),
          Gaps.v14,
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: lectureList.length,
              itemBuilder: (context, index) {
                final lecture = lectureList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: GestureDetector(
                    onTap: () => gotoLecture(context, lecture),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: CachedNetworkImage(
                            imageUrl: lecture['thumbnailPath'],
                            fit: BoxFit.fill,
                            width: 170,
                            height: 130,
                          ),
                        ),
                        Gaps.v10,

                        // 텍스트 섹션
                        Text(
                          lecture['title'] ?? "No title",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void gotoLecture(BuildContext context, dynamic lecture) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LectureDetailPage(lecture: lecture),
      ),
    );
  }
}

class LectureDetailPage extends StatelessWidget {
  final dynamic lecture;

  const LectureDetailPage({super.key, required this.lecture});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lecture['title'] ?? "Lecture Detail"),
      ),
      body: Center(
        child: Text("Details for: ${lecture['title']}"),
      ),
    );
  }
}

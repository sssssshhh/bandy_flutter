import 'package:bandy_flutter/constants/bandy.dart';
import 'package:bandy_flutter/constants/fonts.dart';
import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/pages/lectures/lecture.dart';
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
    await Future.wait<void>([
      setPodcast(),
      setConfusedKorean(),
      setBitesizeStory(),
    ]);

    setState(() {
      isLoading = false; // 데이터 로드가 완료되면 로딩 상태를 false로 설정
    });
  }

  void test() {
    _db.collection("cities").doc("LA").set({"test": "1", "iddd": "22"}).onError(
        (e, _) => print("Error writing document: $e"));
  }

  @override
  Widget build(BuildContext context) {
    test();
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
          Row(
            children: [
              IconButton(
                icon: Icon(icon, color: Colors.black),
                onPressed: () {}, // Not use
              ),
              Text(
                title,
                style: Fonts.titleMedium,
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Lecture(category: category, level: 'level_1'),
                        ),
                      );
                    },
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
}

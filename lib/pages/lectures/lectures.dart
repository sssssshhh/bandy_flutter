import 'package:bandy_flutter/constants/bandy.dart';
import 'package:bandy_flutter/constants/fonts.dart';
import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/pages/lectures/lecture.dart';
import 'package:bandy_flutter/widgets/completed.dart';
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
  Map<String, dynamic> completedStatus = {
    "status": 0,
    Bandy.podcast: "",
    Bandy.confusedKorean: "",
    Bandy.bitesizeStory: "",
  };

  bool isLoading = true;
  String nickname = '';
  String level = '';

  Future<void> setBitesizeStory() async {
    final dbs = await _db.collection('lectures').doc(Bandy.bitesizeStory).collection(level).get();

    setState(() {
      bitesizeStories = dbs.docs
          .map((doc) => {
                'id': int.parse(doc.id),
                ...doc.data(),
              })
          .toList();

      bitesizeStories.sort((a, b) => a['id'].compareTo(b['id']));
    });
  }

  Future<void> setPodcast() async {
    final dbs = await _db.collection('lectures').doc(Bandy.podcast).collection(level).get();

    podcasts = dbs.docs
        .map((doc) => {
              'id': int.parse(doc.id),
              ...doc.data(),
            })
        .toList();

    podcasts.sort((a, b) => a['id'].compareTo(b['id']));
  }

  Future<void> setConfusedKorean() async {
    final dbs = await _db.collection('lectures').doc(Bandy.confusedKorean).collection(level).get();

    setState(() {
      confusedKoreans = dbs.docs
          .map((doc) => {
                'id': int.parse(doc.id),
                ...doc.data(),
              })
          .toList();

      confusedKoreans.sort((a, b) => a['id'].compareTo(b['id']));
    });
  }

  Future<void> setCompletedStatus() async {
    final dbs = await _db
        .collection('users')
        .doc(_auth.currentUser!.email)
        .collection("completedLectures")
        .doc(level)
        .get();

    if (dbs.exists && dbs.data() != null) {
      setState(() {
        completedStatus = dbs.data()!;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initLectures();
  }

  Future<void> initLectures() async {
    await setUserInfo();
    await loadAllLectures();
  }

  Future<void> loadAllLectures() async {
    await Future.wait<void>([
      setPodcast(),
      setConfusedKorean(),
      setBitesizeStory(),
      setCompletedStatus(),
    ]);

    setState(() {
      isLoading = false;
    });
  }

  Future<void> setUserInfo() async {
    String? email;
    if (_auth.currentUser?.email != null) {
      email = _auth.currentUser!.email;
    }

    final dbs = await _db.collection('users').doc(email).get();
    if (dbs.exists && dbs.data() != null) {
      setState(() {
        nickname = dbs.data()?['nickname'];
        level = dbs.data()?['level'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Recommendation(
                  nickname: nickname,
                  lecture: confusedKoreans[1],
                  completedLectureList: completedStatus[Bandy.bitesizeStory].split(','),
                ),
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
    List completedLectureList = [];

    switch (category) {
      case Bandy.podcast:
        icon = Icons.mic;
        title = 'Korean Podcast';
        completedLectureList = completedStatus[Bandy.bitesizeStory].split(',');

        break;
      case Bandy.confusedKorean:
        icon = Icons.search;
        title = 'Confused Korean';
        completedLectureList = completedStatus[Bandy.confusedKorean].split(',');

        break;
      case Bandy.bitesizeStory:
        icon = Icons.menu_book_sharp;
        title = 'Bitesize Story';
        completedLectureList = completedStatus[Bandy.bitesizeStory].split(',');

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
                final lessonNo = index + 1;
                final isCompleted = completedLectureList.contains(lessonNo.toString());

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Lecture(
                            category: category,
                            level: level,
                            lecture: lecture,
                            lessonNo: lessonNo,
                            completedLectureList: completedLectureList,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Stack(
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
                            if (isCompleted) const CompletedLabel()
                          ],
                        ),
                        Gaps.v10,
                        Text(
                          (lecture['title'] ?? "").length > 30
                              ? '${(lecture['title'] ?? "").substring(0, 15)}...'
                              : lecture['title'] ?? "",
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

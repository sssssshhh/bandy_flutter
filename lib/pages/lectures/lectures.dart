import 'dart:convert';
import 'package:bandy_flutter/constants/bandy.dart';
import 'package:bandy_flutter/constants/cloudFrontPath.dart';
import 'package:bandy_flutter/constants/fonts.dart';
import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/widgets/recommendation.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';

class Lectures extends StatefulWidget {
  const Lectures({super.key});

  @override
  State<Lectures> createState() => _LecturesState();
}

class _LecturesState extends State<Lectures> {
  Future<List<dynamic>>? podcasts;
  Future<List<dynamic>>? confusedKoreans;
  Future<List<dynamic>>? bitesizeStories;

  @override
  void initState() {
    super.initState();
    podcasts = loadLectures(Bandy.podcast);
    confusedKoreans = loadLectures(Bandy.confusedKorean);
    bitesizeStories = loadLectures(Bandy.bitesizeStory);
  }

  Future<List<dynamic>> loadLectures(String category) async {
    final String response =
        await rootBundle.loadString('assets/text/data.json');
    final data = await json.decode(response);
    return data[category] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: podcasts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No lectures found.'));
          }
          final List<dynamic> podcastList = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Recommendation(),
                clips(podcastList, 'podcast'),
                FutureBuilder<List<dynamic>>(
                  future: confusedKoreans,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text('No Confused Korean lectures found.'));
                    }
                    return clips(snapshot.data!, 'confused_korean');
                  },
                ),
                FutureBuilder<List<dynamic>>(
                  future: bitesizeStories,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text('No Bitesize Stories found.'));
                    }
                    return clips(snapshot.data!, 'bitesize_story');
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Padding clips(List<dynamic> lectureList, String category) {
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
        icon = Icons.error; // Default icon in case of an unknown category
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

// Example LectureDetailPage widget
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

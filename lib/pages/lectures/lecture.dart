import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/pages/lectures/content.dart';
import 'package:bandy_flutter/pages/lectures/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Lecture extends StatefulWidget {
  final String category;
  final String level;
  final int lessonNo;
  final Map<String, dynamic> lecture;

  const Lecture({
    super.key,
    required this.category,
    required this.level,
    required this.lecture,
    required this.lessonNo,
  });

  @override
  State<Lecture> createState() => _LectureState();
}

class _LectureState extends State<Lecture> with SingleTickerProviderStateMixin {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late VideoPlayerController _videoPlayerController;
  late TabController _tabController;
  bool _isPaused = true;
  bool _isInitialized = false;
  bool _isLoading = true;
  String _progessStatus = "0";
  bool _isIconVisible = false;

  List<Map<String, dynamic>> lectureList = [];

  Future<void> setLectures() async {
    final dbs = await _db
        .collection('lectures')
        .doc(widget.category)
        .collection(widget.level)
        .get();

    setState(() {
      lectureList = dbs.docs.map((doc) => doc.data()).toList();
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
        _progessStatus = dbs.data()?['status'];
      });
    }
  }

  Future<void> loadAllLectures() async {
    await Future.wait<void>([
      setLectures(),
    ]);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();

    _tabController = TabController(length: 3, vsync: this);
    loadAllLectures();
    setUserInfo();
  }

  void _initializeVideoPlayer() {
    _videoPlayerController = VideoPlayerController.network(
      widget.lecture['masterVideoPath'],
    )..initialize().then((_) {
        setState(() {
          _isInitialized = true;
          _videoPlayerController.pause();
        });
      }).catchError((error) {
        print('Error initializing video player: $error');
      });
  }

  void _loadVideoAtIndex(int index) {
    setState(() {
      _isInitialized = false;
    });

    _videoPlayerController.dispose();
    _initializeVideoPlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _onTogglePause() {
    if (!_isInitialized) return;

    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
    } else {
      _videoPlayerController.play();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _onVideoTap() {
    setState(() {
      _isIconVisible = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isIconVisible = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                SizedBox(
                  height: 200,
                  width: 300,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        _isInitialized
                            ? GestureDetector(
                                onTap: _onVideoTap,
                                child: VideoPlayer(_videoPlayerController),
                              )
                            : Container(
                                color: Colors.grey,
                                child: const Center(
                                    child: CircularProgressIndicator()),
                              ),
                        _isInitialized && _isIconVisible
                            ? IconButton(
                                iconSize: 64.0,
                                icon: Icon(
                                  _isPaused ? Icons.play_arrow : Icons.pause,
                                  color: Colors.grey,
                                ),
                                onPressed: _onTogglePause,
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
                Gaps.v10,
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.amber[100],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            'lesson ${widget.lessonNo}',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange[500],
                            ),
                          ),
                        ),
                        Gaps.v10,
                        Text(
                          widget.lecture['title'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.black,
                  indicatorWeight: 1.0,
                  tabs: const [
                    Tab(text: 'Contents'),
                    Tab(text: 'Courses'),
                    Tab(text: 'Progress'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Center(
                        child: Contents(widget: widget),
                      ),
                      Center(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16.0),
                          itemCount: lectureList.length,
                          itemBuilder: (context, index) {
                            final lecture = lectureList[index];

                            return GestureDetector(
                              onTap: () => _loadVideoAtIndex(index),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: CachedNetworkImage(
                                        imageUrl: lecture['thumbnailPath'],
                                        fit: BoxFit.contain,
                                        width: 90,
                                        height: 100,
                                      ),
                                    ),
                                    Gaps.h10,
                                    Expanded(
                                      child: Text(
                                        lecture['title'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Progress(
                        progressStatus: _progessStatus,
                        category: widget.category,
                        level: widget.level,
                        lessonNo: widget.lessonNo,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

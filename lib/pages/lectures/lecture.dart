import 'package:bandy_flutter/bandy_routes.dart';
import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/pages/lectures/content.dart';
import 'package:bandy_flutter/pages/lectures/progress.dart';
import 'package:bandy_flutter/widgets/completed.dart';
import 'package:bandy_flutter/widgets/custom_video_player/controls.dart';
import 'package:bandy_flutter/widgets/custom_video_player/data_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Lecture extends StatefulWidget {
  final String category;
  final String level;
  final int lessonNo;
  final Map<String, dynamic> lecture;
  final List completedLectureList;

  const Lecture({
    super.key,
    required this.category,
    required this.level,
    required this.lecture,
    required this.lessonNo,
    required this.completedLectureList,
  });

  @override
  State<Lecture> createState() => _LectureState();
}

class _LectureState extends State<Lecture> with SingleTickerProviderStateMixin, RouteAware {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late FlickManager _flickManager;
  late DataManager _dataManager;
  late TabController _tabController;

  bool _isLoading = true;
  String _progressStatus = "0";
  int lessonNo = 0;
  String title = "";

  List<Map<String, dynamic>> videoList = [];

  Future<void> setLectures() async {
    final lectures =
        await _db.collection('lectures').doc(widget.category).collection(widget.level).get();

    setState(() {
      // order lecture list by id
      videoList = lectures.docs
          .map((doc) => {
                'id': int.parse(doc.id),
                ...doc.data(),
              })
          .toList();

      videoList.sort((a, b) => a['id'].compareTo(b['id']));
    });
  }

  Future<void> setUserInfo() async {
    String? email;
    if (_auth.currentUser?.email != null) {
      email = _auth.currentUser!.email;
    }

    final dbs = await FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .collection("completedLectures")
        .doc(widget.level)
        .get();

    if (dbs.exists && dbs.data() != null) {
      setState(() {
        final status = dbs.data()?['status'];
        if (status is int) {
          _progressStatus = status.toString();
        } else {
          _progressStatus = status;
        }
      });
    }
  }

  Future<void> loadAllLectures() async {
    await Future.wait<void>([
      setLectures(),
    ]);

    setState(() {
      _isLoading = false;
      lessonNo = widget.lessonNo;
      title = widget.lecture["title"];
    });
  }

  @override
  void initState() {
    super.initState();

    final masterVideoPath = widget.lecture['masterVideoPath'];

    _initializeVideo(masterVideoPath);

    loadAllLectures();
    setUserInfo();
    _tabController = TabController(length: 3, vsync: this);
  }

  void _initializeVideo(String masterVideoPath) {
    _flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(masterVideoPath)),
      autoPlay: false,
      onVideoEnd: () {
        _dataManager.skipToNextVideo(const Duration(seconds: 5));
      },
    );

    _dataManager = DataManager(flickManager: _flickManager, urls: [masterVideoPath]);
  }

  Future<void> setLectureDetail(
      String masterVideoPath, String titleParameter, int lessonNoParameter) async {
    _flickManager.handleChangeVideo(VideoPlayerController.networkUrl(Uri.parse(masterVideoPath)));

    setState(() {
      lessonNo = lessonNoParameter;
      title = titleParameter;
    });
  }

  void _loadVideoAtIndex(String masterVideoPath, String title, int lessonNo) {
    // _flickManager.dispose();
    setLectureDetail(masterVideoPath, title, lessonNo);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    BandyRoutes.pageRouteObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    //
  }

  @override
  void didPushNext() {
    _flickManager.flickControlManager?.pause();
  }

  @override
  void dispose() {
    _flickManager.dispose();
    _tabController.dispose();
    BandyRoutes.pageRouteObserver.unsubscribe(this);

    super.dispose();
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      FlickVideoPlayer(
                        flickManager: _flickManager,
                        flickVideoWithControls: FlickVideoWithControls(
                          controls: CustomOrientationControls(dataManager: _dataManager),
                        ),
                        flickVideoWithControlsFullscreen: FlickVideoWithControls(
                          videoFit: BoxFit.fitWidth,
                          controls: CustomOrientationControls(dataManager: _dataManager),
                        ),
                      ),
                    ],
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
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.amber[100],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            'lesson $lessonNo',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange[500],
                            ),
                          ),
                        ),
                        Gaps.v10,
                        Text(
                          title,
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
                          itemCount: videoList.length,
                          itemBuilder: (context, index) {
                            final lecture = videoList[index];
                            final lessonNo = index + 1;
                            final isCompleted =
                                widget.completedLectureList.contains(lessonNo.toString());
                            return GestureDetector(
                              onTap: () => _loadVideoAtIndex(
                                  lecture['masterVideoPath'], lecture['title'], lessonNo),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Stack(children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: CachedNetworkImage(
                                          imageUrl: lecture['thumbnailPath'],
                                          fit: BoxFit.contain,
                                          width: 90,
                                          height: 100,
                                        ),
                                      ),
                                      if (isCompleted) const CompletedLabel()
                                    ]),
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
                        progressStatus: _progressStatus,
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

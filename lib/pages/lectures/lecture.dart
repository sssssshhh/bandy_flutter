import 'package:bandy_flutter/constants/cloudFrontPath.dart';
import 'package:bandy_flutter/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

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
  late VideoPlayerController _videoPlayerController;
  bool _isPaused = true;
  bool _isInitialized = false;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
    _tabController = TabController(length: 3, vsync: this); // 3개의 탭 설정
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

    _videoPlayerController.dispose(); // 이전 컨트롤러 해제
    _initializeVideoPlayer(); // 새 컨트롤러 초기화
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _tabController.dispose(); // TabController 해제
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            child: Stack(
              alignment: Alignment.center,
              children: [
                _isInitialized
                    ? GestureDetector(
                        onTap: _onTogglePause,
                        child: VideoPlayer(_videoPlayerController),
                      )
                    : Container(
                        color: Colors.grey,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                _isInitialized
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
          Gaps.v10,
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
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
                  child: Padding(
                    padding: const EdgeInsets.all(34.0),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Notes',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              'KOR',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gaps.v10,
                      Text(widget.lecture['korExplanation'])
                    ]),
                  ),
                ),
                const Center(child: Text('Content for Tab 2')),
                const Center(child: Text('Content for Tab 3')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

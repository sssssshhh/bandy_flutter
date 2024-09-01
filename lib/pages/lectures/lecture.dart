import 'package:bandy_flutter/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Lecture extends StatefulWidget {
  final String category;
  final String level;

  const Lecture({
    super.key,
    required this.category,
    required this.level,
  });

  @override
  State<Lecture> createState() => _LectureState();
}

class _LectureState extends State<Lecture> {
  late VideoPlayerController _videoPlayerController;
  bool _isPaused = true;
  bool _isInitialized = false;
  int _currentLectureIndex = 1;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() {
    _videoPlayerController = VideoPlayerController.network(
      'https://bandy-contents.s3.ap-northeast-1.amazonaws.com/${widget.category}/${widget.level}/master/LV1_$_currentLectureIndex.mp4',
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
      _currentLectureIndex = index + 1;
    });

    _videoPlayerController.dispose(); // Dispose of the previous controller
    _initializeVideoPlayer(); // Initialize a new controller with the new index
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
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
        title: Text(
          widget.category,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
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
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.white,
                child: Column(
                  children: List.generate(
                    10,
                    (index) => GestureDetector(
                      onTap: () => _loadVideoAtIndex(index),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: Colors.grey),
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://bandy-contents.s3.ap-northeast-1.amazonaws.com/${widget.category}/${widget.level}/thumbnail/lv1_${index + 1}.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Gaps.h12,
                          Expanded(
                            child: Text(
                              'Lecture ${index + 1}',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.deepOrange),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

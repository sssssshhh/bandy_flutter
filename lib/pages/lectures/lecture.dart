import 'dart:ffi';

import 'package:bandy_flutter/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Lecture extends StatefulWidget {
  const Lecture({super.key});

  @override
  State<Lecture> createState() => _LectureState();
}

class _LectureState extends State<Lecture> {
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset('assets/videos/test.mp4');

  bool _isPaused = false;

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    _videoPlayerController.play();
    setState(() {});
  }

  void _onTogglePause() {
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
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: _videoPlayerController.value.isInitialized
              ? VideoPlayer(_videoPlayerController)
              : Container(color: Colors.amberAccent // TODO: to make screen
                  ),
        ),
        Positioned.fill(
          child: GestureDetector(
            onTap: _onTogglePause,
          ),
        ),
      ],
    );
  }
}

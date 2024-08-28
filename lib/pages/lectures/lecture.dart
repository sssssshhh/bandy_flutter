import 'package:bandy_flutter/constants/fonts.dart';
import 'package:bandy_flutter/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Lecture extends StatefulWidget {
  const Lecture({super.key});

  @override
  State<Lecture> createState() => _LectureState();
}

class _LectureState extends State<Lecture> {
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.network(
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
  );
  // final VideoPlayerController _videoPlayerController =
  //     VideoPlayerController.asset('assets/videos/test.mp4');

  bool _isPaused = false;

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    _videoPlayerController.pause();
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
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Stack(
              alignment: Alignment.center,
              children: [
                _videoPlayerController.value.isInitialized
                    ? GestureDetector(
                        onTap: _onTogglePause,
                        child: VideoPlayer(_videoPlayerController),
                      )
                    : Container(
                        color: Colors.white,
                      ),
                _videoPlayerController.value.isInitialized
                    ? IconButton(
                        iconSize: 64.0,
                        icon: Icon(
                          _isPaused ? Icons.play_arrow : Icons.pause,
                          color: Colors.white,
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
                alignment: Alignment.topLeft,
                color: Colors.white,
                child: const Column(
                  children: [
                    Text(
                      "Let's learn about folk remedies!",
                      style: Fonts.titleLMedium,
                    ),
                    Gaps.v16,
                    Text(
                      "In Korea, there are several folk remedies, These can be used to treat some minor ailments. For example, when you have a cold or a sore throat, you can boil ginger and cola together to make 'ginger cola.' When you drink it, your throat feels hot and it feels like drinking ginger tea. It can increase heat, warm the stomach, and has the effects of preventing colds and reducing phlegm.It is also effective for sore throats and tonsillitis caused by colds.Additionally, some people like iced sugar pears. Cut the pear, scoop out the inside, and then put rock sugar and dates in and steam it. This also helps to remove the cold.",
                      style: Fonts.titleSmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

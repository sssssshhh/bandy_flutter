import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class ListenSpeak extends StatefulWidget {
  final List<Map<String, dynamic>> expressionList;
  const ListenSpeak({
    super.key,
    required this.expressionList,
  });

  @override
  State<ListenSpeak> createState() => _ListenSpeakState();
}

class _ListenSpeakState extends State<ListenSpeak> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  Future<void> _playAudio() async {
    await _audioPlayer
        .play(UrlSource(widget.expressionList[0]['expressionAudioPath']));
    setState(() {
      _isPlaying = true;
    });
  }

  Future<void> _stopAudio() async {
    await _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
    });
  }

  Future<void> _toggleAudio() async {
    if (_isPlaying) {
      await _stopAudio();
    } else {
      await _playAudio();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(), // TODO: go to lecture
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size20,
          horizontal: Sizes.size40,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Listen and repeat",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 400,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _toggleAudio,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (_isPlaying)
                          Positioned(
                            child: Container(
                              width: 70,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.yellow.withOpacity(0.6), // 레몬색
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        if (_isPlaying)
                          Positioned(
                            child: Container(
                              width: 120,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.yellow.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(35),
                              ),
                            ),
                          ),
                        const Icon(
                          Icons.headphones,
                          color: Colors.orange,
                          size: 48,
                        ),
                      ],
                    ),
                  ),
                  Gaps.v16,
                  Text(
                    widget.expressionList[0]['korAnswer'],
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v8,
                  Text(
                    widget.expressionList[0]['engAnswer'],
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Press and speak',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Gaps.v28,
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.keyboard_voice_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                Gaps.v20,
              ],
            ),
          ],
        ),
      ),
    );
  }
}

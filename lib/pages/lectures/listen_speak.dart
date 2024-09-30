import 'package:bandy_flutter/pages/authentication/widget/form_button.dart';
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
  bool _isListening = false; // 마이크 리스닝 상태
  bool _isRecordingComplete = false; // 녹음 완료 상태

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

  Future<void> _toggleListening() async {
    if (_isListening) {
      // 마이크 클릭 시 녹음 완료 상태로 변경
      setState(() {
        _isListening = false;
        _isRecordingComplete = true;
      });
    } else {
      // 오디오 중지
      await _stopAudio();
      // 상태 변경
      setState(() {
        _isListening = true;
        _isPlaying = false; // 오디오 재생 중지
        _isRecordingComplete = false; // 초기화
      });

      // 2초 후 녹음 완료 상태로 변경 (예시, 실제 녹음 로직에 따라 변경 가능)
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(), // TODO: go to lecture
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 40.0,
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
                        // 오디오가 재생 중일 때 타원형 표시
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
                        // 헤드폰 아이콘
                        Icon(
                          Icons.headphones,
                          color: _isPlaying
                              ? Colors.orange
                              : Colors.grey, // 재생 중일 때 오렌지색
                          size: 48,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // 녹음 완료 후 A, B 텍스트 표시
                  Text(
                    widget.expressionList[0]['korAnswer'],
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
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
                // 흰 컨테이너 밖의 타원형
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _isListening ||
                          _isRecordingComplete // Listening 또는 녹음 완료 상태일 때 텍스트 변경
                      ? const Text(
                          'Listening...',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Press and speak',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _toggleListening, // 마이크 버튼 클릭 시 리스닝 토글
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: _isListening
                          ? Colors.orange
                          : Colors.grey[400], // 리스닝 중일 때 오렌지색
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.keyboard_voice_rounded,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // 녹음 완료 후 Check result 버튼 표시
                if (_isRecordingComplete)
                  Column(
                    children: [
                      // 녹음 완료 텍스트
                      const Text(
                        'Recording complete',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {},
                        child: const FormButton(
                          text: 'Check',
                          disabled: false,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

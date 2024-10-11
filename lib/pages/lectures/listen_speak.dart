import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bandy_flutter/pages/lectures/Pronunciation_assessment_results.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_sound_record/flutter_sound_record.dart';
import 'package:http/http.dart' as http;

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
  Timer? _timer;
  Timer? _ampTimer;
  int _recordDuration = 0;
  Amplitude? _amplitude;
  final FlutterSoundRecord _audioRecorder = FlutterSoundRecord();
  bool _isRecording = false;

  @override
  void initState() {
    _isRecording = false;
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _ampTimer?.cancel();
    _audioRecorder.dispose();
    super.dispose();
  }

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

  Future<void> _toggleRecording() async {
    if (_isListening) {
      print("if");

      await _stopAudio();
      _stop();
      // 마이크 클릭 시 녹음 완료 상태로 변경
      setState(() {
        _isListening = false;
        _isRecordingComplete = true;
      });
    } else {
      print("else");

      _start();
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

  Future<String> convertM4aToWav(String inputPath) async {
    print("convertM4aToWav");
    String outputPath = inputPath.replaceAll(".m4a", ".wav");
    await FFmpegKit.execute(
            "-i $inputPath -acodec pcm_s16le -ar 44100 $outputPath")
        .then((session) async {
      final duration = await session.getDuration();
      print("Convert m4a to wav duration: $duration");
    });

    return outputPath;
  }

  Future<void> fetchAndSendAudio(String wavPath) async {
    // delete file://
    String filePath = wavPath.replaceFirst('file://', '');

    File file = File(filePath);

    if (await file.exists()) {
      final url = Uri.parse(
          'https://qw08qinwif.execute-api.ap-northeast-1.amazonaws.com/default/getPresignedURL');

      try {
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          // extract pre-signed URL
          final presignedUrl = data['url'];
          print('Pre-signed URL: $presignedUrl');

          // Upload file
          final uploadResponse = await http.put(
            Uri.parse(presignedUrl),
            body: file.readAsBytesSync(),
            headers: {
              'Content-Type': 'audio/wav',
            },
          );

          if (uploadResponse.statusCode == 200) {
            print('File uploaded successfully!');
          } else {
            print('Failed to upload file: ${uploadResponse.statusCode}');
          }
        } else {
          print('Failed to fetch pre-signed URL: ${response.statusCode}');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _ampTimer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });

    _ampTimer =
        Timer.periodic(const Duration(milliseconds: 200), (Timer t) async {
      _amplitude = await _audioRecorder.getAmplitude();
      setState(() {});
    });
  }

  Future<void> _start() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        await _audioRecorder.start();

        bool isRecording = await _audioRecorder.isRecording();
        setState(() {
          _isRecording = isRecording;
          _recordDuration = 0;
        });

        _startTimer();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _stop() async {
    _timer?.cancel();
    _ampTimer?.cancel();
    final String? path = await _audioRecorder.stop();
    if (path != null) {
      _sendRecording(path);
    } else {
      print("Recording path is null.");
    }

    setState(() => _isRecording = false);
  }

  Future<void> _sendRecording(String path) async {
    String wavPath = await convertM4aToWav(path);

    fetchAndSendAudio(wavPath);
  }

  void _onNextTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PronunciationAssessmentResults(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(), // TODO: go to lecture
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 30.0,
          horizontal: 40.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  onTap: _toggleRecording, // 마이크 버튼 클릭 시 리스닝 토글
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
                )

                // const SizedBox(height: 20),
                // 녹음 완료 후 Check result 버튼 표시
                // if (_isRecordingComplete)
                //   const Column(
                //     children: [
                //       // 녹음 완료 텍스트
                //       Text(
                //         'Recording complete',
                //         style: TextStyle(
                //           color: Colors.black,
                //           fontSize: 18,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                // const SizedBox(height: 20),
                // GestureDetector(
                //   onTap: _onNextTap,
                //   child: const FormButton(
                //     text: 'Check',
                //     disabled: false,
                //   ),
                // ),
                //   ],
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

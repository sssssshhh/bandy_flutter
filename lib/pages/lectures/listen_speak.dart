import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bandy_flutter/pages/lectures/pronunciation_assessment_results.dart';
import 'package:bandy_flutter/widgets/action_button.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_sound_record/flutter_sound_record.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class ListenSpeak extends StatefulWidget {
  final List<Map<String, dynamic>> expressionList;
  final int lessonNo;
  final String level;
  final String category;

  const ListenSpeak({
    super.key,
    required this.expressionList,
    required this.lessonNo,
    required this.level,
    required this.category,
  });

  @override
  State<ListenSpeak> createState() => _ListenSpeakState();
}

class _ListenSpeakState extends State<ListenSpeak> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final FlutterSoundRecord _audioRecorder = FlutterSoundRecord();

  bool _isPlaying = false;
  bool _showRecording = false;
  bool _isRecordingCompleted = false;
  bool _isRecording = false;
  int _recordDuration = 0;
  String fileName = "";

  Timer? _timer;
  Timer? _ampTimer;

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
      _showRecording = true;
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
    if (_isRecording) {
      await _stopAudio();
      _stopRecording();

      setState(() {
        _isRecording = false;
        _isRecordingCompleted = false;
      });
    } else {
      _startRecording();

      setState(() {
        _isRecording = true;
        _isPlaying = false;
        _isRecordingCompleted = false;
      });

      await Future.delayed(const Duration(seconds: 2));
    }
  }

  Future<String> convertM4aToWav(String inputPath) async {
    String outputPath = inputPath.replaceAll(".m4a", ".wav");
    await FFmpegKit.execute(
            "-i $inputPath -acodec pcm_s16le -ar 44100 $outputPath")
        .then((session) async {});

    return outputPath;
  }

  Future<void> fetchAndSendAudio(String wavPath) async {
    String filePath = wavPath.replaceFirst('file://', '');

    File file = File(filePath);

    if (await file.exists()) {
      final url = Uri.parse(
          'https://qw08qinwif.execute-api.ap-northeast-1.amazonaws.com/default/getPresignedURL');

      try {
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final data = json.decode(response.body);

          final presignedUrl = data['url'];

          final uploadResponse = await http.put(
            Uri.parse(presignedUrl),
            body: file.readAsBytesSync(),
            headers: {
              'Content-Type': 'audio/wav',
            },
          );

          if (uploadResponse.statusCode == 200) {
            debugPrint('File uploaded successfully!');

            setState(() {
              fileName = data['fileName'];
            });
          } else {
            debugPrint('Failed to upload file: ${uploadResponse.statusCode}');
          }
        } else {
          debugPrint('Failed to fetch pre-signed URL: ${response.statusCode}');
        }
      } catch (e) {
        debugPrint('Error: $e');
      }
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _ampTimer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });
  }

  Future<void> _startRecording() async {
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

  Future<void> _stopRecording() async {
    _timer?.cancel();
    _ampTimer?.cancel();
    final String? path = await _audioRecorder.stop();
    if (path != null) {
      _sendRecording(path);
    } else {
      debugPrint("Recording path is null.");
    }
    setState(() {
      _isRecording = false;
      _isRecordingCompleted = true;
    });
  }

  Future<void> _sendRecording(String path) async {
    String wavPath = await convertM4aToWav(path);
    fetchAndSendAudio(wavPath);
  }

  void _onNextTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PronunciationAssessmentResults(
          fileName: fileName,
          korAnswer: widget.expressionList[0]['korAnswer'],
          lessonNo: widget.lessonNo,
          level: widget.level,
          category: widget.category,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        final double listenContainerHeight =
            viewportConstraints.maxHeight * 0.425;
        final double recordingButtonSpace =
            viewportConstraints.maxHeight * 0.057;

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 30,
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Listen and repeat",
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0xFF1A1A1A),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    height: listenContainerHeight,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFEAEAEA)),
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Color(0x14000000),
                          blurRadius: 12,
                          spreadRadius: 4,
                          offset: Offset(0, 4),
                        )
                      ],
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
                                      color:
                                          Colors.yellow.withOpacity(0.6), // 레몬색
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
                              SvgPicture.asset(
                                'assets/svg/speaker.svg',
                                colorFilter: ColorFilter.mode(
                                    _isPlaying
                                        ? const Color(0xFFF2BC40)
                                        : const Color(0xFFBEBEBE),
                                    BlendMode.srcIn),
                                width: 48,
                                height: 48,
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.expressionList[0]['engAnswer'],
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: recordingButtonSpace),
                  if (_showRecording) _buildRecordingView(),
                ],
              ),
              if (_isRecordingCompleted)
                ActionButton(
                  text: 'Check result',
                  onPressed: () => _onNextTap(),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildRecordingView() {
    return Column(
      children: [
        if (!_isRecordingCompleted)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: _isRecording
                ? const Text(
                    'Listening...',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                : const Text(
                    'Press and speak',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
          ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: _toggleRecording,
          child: Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              color: _isRecording ? Colors.orange : Colors.grey[400],
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.keyboard_voice_rounded,
              color: Colors.white,
              size: 64,
            ),
          ),
        ),
        const SizedBox(height: 20),
        if (_isRecordingCompleted)
          (fileName == "")
              ? const Center(child: CircularProgressIndicator())
              : const Text(
                  'Recording complete',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
      ],
    );
  }
}

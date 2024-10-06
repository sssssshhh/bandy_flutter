import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound_record/flutter_sound_record.dart';
import 'package:just_audio/just_audio.dart' as ap;
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:http/http.dart' as http;

class AudioRecorder extends StatefulWidget {
  const AudioRecorder({required this.onStop, super.key});

  final void Function(String path) onStop;

  @override
  _AudioRecorderState createState() => _AudioRecorderState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        ObjectFlagProperty<void Function(String path)>.has('onStop', onStop));
  }
}

class _AudioRecorderState extends State<AudioRecorder> {
  bool _isRecording = false;
  bool _isPaused = false;
  int _recordDuration = 0;
  Timer? _timer;
  Timer? _ampTimer;
  final FlutterSoundRecord _audioRecorder = FlutterSoundRecord();
  Amplitude? _amplitude;

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildRecordStopControl(),
                const SizedBox(width: 20),
                _buildPauseResumeControl(),
                const SizedBox(width: 20),
                _buildText(),
              ],
            ),
            if (_amplitude != null) ...<Widget>[
              const SizedBox(height: 40),
              Text('Current: ${_amplitude?.current ?? 0.0}'),
              Text('Max: ${_amplitude?.max ?? 0.0}'),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRecordStopControl() {
    late Icon icon;
    late Color color;

    if (_isRecording || _isPaused) {
      icon = const Icon(Icons.stop, color: Colors.red, size: 30);
      color = Colors.red.withOpacity(0.1);
    } else {
      final ThemeData theme = Theme.of(context);
      icon = Icon(Icons.mic, color: theme.primaryColor, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 56, height: 56, child: icon),
          onTap: () {
            _isRecording ? _stop() : _start();
          },
        ),
      ),
    );
  }

  Widget _buildPauseResumeControl() {
    if (!_isRecording && !_isPaused) {
      return const SizedBox.shrink();
    }

    late Icon icon;
    late Color color;

    if (!_isPaused) {
      icon = const Icon(Icons.pause, color: Colors.red, size: 30);
      color = Colors.red.withOpacity(0.1);
    } else {
      final ThemeData theme = Theme.of(context);
      icon = const Icon(Icons.play_arrow, color: Colors.red, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 56, height: 56, child: icon),
          onTap: () {
            _isPaused ? _resume() : _pause();
          },
        ),
      ),
    );
  }

  Widget _buildText() {
    if (_isRecording || _isPaused) {
      return _buildTimer();
    }

    return const Text('Waiting to record');
  }

  Widget _buildTimer() {
    final String minutes = _formatNumber(_recordDuration ~/ 60);
    final String seconds = _formatNumber(_recordDuration % 60);

    return Text(
      '$minutes : $seconds',
      style: const TextStyle(color: Colors.red),
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0$numberStr';
    }

    return numberStr;
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

    widget.onStop(path!);

    setState(() => _isRecording = false);
  }

  Future<void> _pause() async {
    _timer?.cancel();
    _ampTimer?.cancel();
    await _audioRecorder.pause();

    setState(() => _isPaused = true);
  }

  Future<void> _resume() async {
    _startTimer();
    await _audioRecorder.resume();

    setState(() => _isPaused = false);
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
}

Future<String> convertM4aToWav(String inputPath) async {
  String outputPath = inputPath.replaceAll(".m4a", ".wav");
  await FFmpegKit.execute(
          "-i $inputPath -acodec pcm_s16le -ar 44100 $outputPath")
      .then((session) async {
    final duration = await session.getDuration();
    print("Convert m4a to wav duration: $duration");
  });

  return outputPath;
}

void main() {
  runApp(const PronunciationAssessment());
}

class PronunciationAssessment extends StatefulWidget {
  const PronunciationAssessment({super.key});

  @override
  _PronunciationAssessmentState createState() =>
      _PronunciationAssessmentState();
}

class _PronunciationAssessmentState extends State<PronunciationAssessment> {
  bool showPlayer = false;
  String stringPath = '';
  ap.AudioSource? audioSource;

  @override
  void initState() {
    showPlayer = false;
    super.initState();
  }

  Future<void> fetchAndSendAudio(String wavPath) async {
    // file:// 스킴 제거
    String filePath = wavPath.replaceFirst('file://', '');

    File file = File(filePath);

    if (await file.exists()) {
      final url = Uri.parse(
          'https://qw08qinwif.execute-api.ap-northeast-1.amazonaws.com/default/getPresignedURL'); // API Gateway URL

      try {
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final presignedUrl = data['url']; // pre-signed URL 추출
          print('Pre-signed URL: $presignedUrl');

          // 파일 업로드
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: showPlayer
              ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Text("Audio Play!"))
              : AudioRecorder(
                  onStop: (String path) async {
                    audioSource = ap.AudioSource.uri(Uri.parse(path));
                    String wavPath = await convertM4aToWav(path);
                    stringPath = wavPath;
                    fetchAndSendAudio(wavPath);
                    showPlayer = true;
                    setState(() {});
                  },
                ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('showPlayer', showPlayer));
    properties
        .add(DiagnosticsProperty<ap.AudioSource?>('audioSource', audioSource));
  }
}

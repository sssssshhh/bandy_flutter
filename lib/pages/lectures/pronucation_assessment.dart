import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class PronunciationAssessment extends StatefulWidget {
  const PronunciationAssessment({super.key});

  @override
  _PronunciationAssessmentState createState() =>
      _PronunciationAssessmentState();
}

class _PronunciationAssessmentState extends State<PronunciationAssessment> {
  final FlutterSoundPlayer _player = FlutterSoundPlayer();

  Future<void> playRecording() async {
    if (recordingPath.isNotEmpty) {
      await _player.startPlayer(
        fromURI: recordingPath,
        codec: Codec.pcm16WAV,
      );
    }
  }

  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  String recordingPath = "";
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
    _recorder.openRecorder();
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    super.dispose();
  }

  Future<void> startRecording() async {
    final Directory appDocumentDir = await getApplicationDocumentsDirectory();
    final String filePath = p.join(appDocumentDir.path, "recordings.wav");

    await _recorder.startRecorder(
      toFile: filePath,
      codec: Codec.pcm16WAV,
      sampleRate: 16000, // 16kHz
      // bitRate: 64000, // 128kbps
    );

    setState(() {
      isRecording = true;
      recordingPath = filePath;
    });
  }

  Future<void> stopRecording() async {
    await _recorder.stopRecorder();
    setState(() {
      isRecording = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: recordingButton(),
      body: buildUI(),
    );
  }

  Widget buildUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (recordingPath.isNotEmpty)
            Text('Recorded file saved at $recordingPath'),
          ElevatedButton(
            onPressed: () async {
              if (isRecording) {
                await stopRecording();
              } else {
                await startRecording();
              }
            },
            child: Text(isRecording ? 'Stop Recording' : 'Start Recording'),
          ),
        ],
      ),
    );
  }

  Widget recordingButton() {
    return FloatingActionButton(
      onPressed: () async {
        if (isRecording) {
          await stopRecording();
        } else {
          await startRecording();
        }
      },
      child: Icon(
        isRecording ? Icons.stop : Icons.mic,
      ),
    );
  }
}

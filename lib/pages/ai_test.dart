import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class AITest extends StatefulWidget {
  const AITest({super.key});

  @override
  State<AITest> createState() => _AITestState();
}

class _AITestState extends State<AITest> {
  final AudioRecorder audioRecorder = AudioRecorder();

  bool isRecording = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _recordingButton(),
    );
  }

  Widget _recordingButton() {
    return FloatingActionButton(
        onPressed: () async {
          if (isRecording) {
          } else {
            if (await audioRecorder.hasPermission()) {
              final Directory appDocumentDir =
                  await getApplicationDocumentsDirectory();
              final String filePath =
                  p.join(appDocumentDir.path, "recording.wav");
              await audioRecorder.start(const RecordConfig(), path: filePath);
              setState(() {
                isRecording = true;
              });
            }
          }
        },
        child: Icon(
          isRecording ? Icons.stop : Icons.mic,
        ));
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:record/record.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class PronunciationAssessment extends StatefulWidget {
  const PronunciationAssessment({super.key});

  @override
  _PronunciationAssessmentState createState() =>
      _PronunciationAssessmentState();
}

class _PronunciationAssessmentState extends State<PronunciationAssessment> {
  final String s3FileUrl =
      'https://bandy-contents.s3.ap-northeast-1.amazonaws.com/test.wav';
  final String apiUrl =
      'https://pronunciation-assessment.vercel.app/api/assessment'; // API URL을 실제로 사용 중인 URL로 변경하세요
  final AudioRecorder audioRecorder = AudioRecorder();

  final record = AudioRecorder();

  String? recordingPath;
  bool isRecording = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 여기서 context를 저장해도 안전하게 사용할 수 있습니다.
  }

  Future<void> fetchAndSendAudio() async {
    try {
      final request = http.Request('POST', Uri.parse(apiUrl))
        ..headers['Content-Type'] = 'application/json';

      final response = await http.get(Uri.parse(s3FileUrl));
      final audioBytes = response.bodyBytes;
      final base64Audio = base64Encode(audioBytes);

      request.body = jsonEncode({'audio': base64Audio});

      final apiResponse = await http.Response.fromStream(await request.send());

      if (apiResponse.statusCode == 200) {
        final responseData = jsonDecode(apiResponse.body);
        print('API Response: $responseData');
        // 여기서 화면을 전환할 때는 이 작업이 완료된 후에 수행하는 것이 좋습니다.
        // if (mounted) {
        //   // 위젯이 활성 상태일 때만 상태 변경
        //   Navigator.pushNamed(context, '/your-next-route'); // 다음 화면으로 이동
        // }
      } else {
        print('Failed to send audio. Status code: ${apiResponse.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

// fetchAndSendAudio
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: recordingButton(),
      body: buildUI(),
    );
  }

  Widget buildUI() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        children: [
          if (recordingPath != null)
            MaterialButton(
                onPressed: fetchAndSendAudio,
                color: const Color.fromARGB(255, 111, 29, 126)),
          if (recordingPath == null) const Text("no recording found"),
        ],
      ),
    );
  }

  Widget recordingButton() {
    return FloatingActionButton(
        onPressed: () async {
          if (isRecording) {
            String? filePath = await audioRecorder.stop();
            if (filePath != null) {
              setState(() {
                isRecording = false;
                recordingPath = filePath;
              });
            }
          } else {
            if (await audioRecorder.hasPermission()) {
              final Directory appDocumentDir =
                  await getApplicationDocumentsDirectory();
              final String filePath =
                  p.join(appDocumentDir.path, "recording.carf");
              await audioRecorder.start(
                  const RecordConfig(
                    sampleRate: 16000, // 16khz
                  ),
                  path: filePath);
              setState(() {
                isRecording = true;
                recordingPath = null;
              });
            }
          }
        },
        child: Icon(
          isRecording ? Icons.stop : Icons.mic,
        ));
  }
}

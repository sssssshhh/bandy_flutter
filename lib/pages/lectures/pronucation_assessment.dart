import 'dart:convert';
import 'package:bandy_flutter/constants/fonts.dart';
import 'package:bandy_flutter/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  final String apiUrl =
      'https://pronunciation-assessment.vercel.app/api/assessment'; // API URL을 실제로 사용 중인 URL로 변경하세요
  //final AudioRecorder audioRecorder = AudioRecorder();
  // final FlutterSoundRecorder _recorder = FlutterSoundRecorder();

  // final record = AudioRecorder();

  String? recordingPath;
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
    openRecorder();
  }

  Future<void> openRecorder() async {
    // await _recorder.openRecorder(); // Recorder를 열어서 초기화
  }

  @override
  void dispose() {
    // _recorder.closeRecorder(); // 자원 해제를 위해 녹음기 닫기
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 여기서 context를 저장해도 안전하게 사용할 수 있습니다.
  }

  // final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> fetchAndSendAudio() async {
    String filePath = recordingPath!;
    File file = File(filePath);
    print(filePath);

    if (await file.exists()) {
      try {
        var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
        request.files.add(await http.MultipartFile.fromPath('audio', filePath));
        request.headers.addAll({
          'Content-Type': 'multipart/form-data',
        });
        var response = await request.send();

        if (response.statusCode == 200) {
          print('File uploaded successfully');
          var responseData = await http.Response.fromStream(response);
          print('Response: ${responseData.body}');
        } else {
          print('Failed to send audio. Status code: ${response.statusCode}');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Text("Temporary"),
      ),
      // body: buildUI(),
    );
  }

  // Widget buildUI() {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text(
  //         'Pronunciation Assessment',
  //       ),
  //     ),
  //     body: SafeArea(
  //       child: Padding(
  //         padding: const EdgeInsets.all(Sizes.size40),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             const Text(
  //               '나는 오늘 학교에 감',
  //               style: Fonts.titleLMedium,
  //             ),
  //             if (recordingPath != null)
  //               GestureDetector(
  //                 onTap: fetchAndSendAudio,
  //                 child: const Row(
  //                   mainAxisAlignment: MainAxisAlignment.end,
  //                   children: [
  //                     Padding(
  //                       padding: EdgeInsets.all(8.0),
  //                       child: Text(
  //                         'Start Asssessment',
  //                         style: Fonts.titleSmall,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             if (recordingPath == null)
  //               FloatingActionButton(
  //                 onPressed: () async {
  //                   if (isRecording) {
  //                     String? filePath = await _recorder.stopRecorder();
  //                     setState(() {
  //                       isRecording = false;
  //                       recordingPath = filePath;
  //                     });
  //                   } else {
  //                     final Directory appDocumentDir =
  //                         await getApplicationDocumentsDirectory();
  //                     String filePath = '${appDocumentDir.path}/recording.wav';
  //                     await _recorder.startRecorder(
  //                       toFile: filePath,
  //                       codec: Codec.pcm16WAV,
  //                       sampleRate: 16000,
  //                       bitRate: 128000,
  //                     );
  //                     setState(() {
  //                       isRecording = true;
  //                       recordingPath = null;
  //                     });
  //                   }
  //                 },
  //                 child: Icon(
  //                   isRecording
  //                       ? FontAwesomeIcons.lightbulb
  //                       : FontAwesomeIcons.microphone,
  //                 ),
  //               )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

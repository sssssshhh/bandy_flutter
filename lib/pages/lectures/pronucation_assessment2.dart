// import 'package:flutter/material.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as p;

// class PronunciationAssessment extends StatefulWidget {
//   const PronunciationAssessment({super.key});

//   @override
//   _PronunciationAssessmentState createState() =>
//       _PronunciationAssessmentState();
// }

// class _PronunciationAssessmentState extends State<PronunciationAssessment> {
//   final FlutterSoundPlayer _player = FlutterSoundPlayer();

//   //   Future<void> fetchAndSendAudio() async {
// //     try {
// //       // 로컬 파일에서 바이트 읽기
// //       final File file = File(recordingPath);
// //       print("recordingPath");
// //       print(recordingPath);
// //       final audioBytes = await file.readAsBytes();
// //       final base64Audio = base64Encode(audioBytes);

// //       final request = http.Request('POST', Uri.parse(apiUrl))
// //         ..headers['Content-Type'] = 'application/json'
// //         ..body = jsonEncode({'audio': base64Audio});

// //       final apiResponse = await http.Response.fromStream(await request.send());

// //       if (apiResponse.statusCode == 200) {
// //         final responseData = jsonDecode(apiResponse.body);
// //         print('API Response: $responseData');
// //         // 여기서 화면을 전환할 때는 이 작업이 완료된 후에 수행하는 것이 좋습니다.
// //         // if (mounted) {
// //         //   Navigator.pushNamed(context, '/your-next-route'); // 다음 화면으로 이동
// //         // }
// //       } else {
// //         print('Failed to send audio. Status code: ${apiResponse.statusCode}');
// //       }
// //     } catch (e) {
// //       print('Error: $e');
// //     }
// //   }

//   Future<void> playRecording() async {
//     if (recordingPath.isNotEmpty) {
//       await _player.startPlayer(
//         fromURI: recordingPath,
//         codec: Codec.pcm16WAV,
//       );
//     }
//   }

//   final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
//   String recordingPath = "";
//   bool isRecording = false;

//   @override
//   void initState() {
//     super.initState();
//     _recorder.openRecorder();
//   }

//   @override
//   void dispose() {
//     _recorder.closeRecorder();
//     super.dispose();
//   }

//   Future<void> startRecording() async {
//     final Directory appDocumentDir = await getApplicationDocumentsDirectory();
//     final String filePath = p.join(appDocumentDir.path, "recordings.wav");

//     await _recorder.startRecorder(
//       toFile: filePath,
//       codec: Codec.pcm16WAV,
//       sampleRate: 16000, // 16kHz
//       // bitRate: 64000, // 128kbps
//     );

//     setState(() {
//       isRecording = true;
//       recordingPath = filePath;
//     });
//   }

//   Future<void> stopRecording() async {
//     await _recorder.stopRecorder();
//     setState(() {
//       isRecording = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       floatingActionButton: recordingButton(),
//       body: buildUI(),
//     );
//   }

//   Widget buildUI() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           if (recordingPath.isNotEmpty)
//             Text('Recorded file saved at $recordingPath'),
//           ElevatedButton(
//             onPressed: () async {
//               if (isRecording) {
//                 await stopRecording();
//               } else {
//                 await startRecording();
//               }
//             },
//             child: Text(isRecording ? 'Stop Recording' : 'Start Recording'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget recordingButton() {
//     return FloatingActionButton(
//       onPressed: () async {
//         if (isRecording) {
//           await stopRecording();
//         } else {
//           await startRecording();
//         }
//       },
//       child: Icon(
//         isRecording ? Icons.stop : Icons.mic,
//       ),
//     );
//   }
// }

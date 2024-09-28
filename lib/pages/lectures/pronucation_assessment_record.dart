// import 'dart:convert';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:bandy_flutter/constants/fonts.dart';
// import 'package:bandy_flutter/constants/sizes.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:record/record.dart';
// import 'dart:io';
// import 'package:path/path.dart' as p;
// import 'package:path_provider/path_provider.dart';

// class PronunciationAssessment extends StatefulWidget {
//   const PronunciationAssessment({super.key});

//   @override
//   _PronunciationAssessmentState createState() =>
//       _PronunciationAssessmentState();
// }

// class _PronunciationAssessmentState extends State<PronunciationAssessment> {
//   final String apiUrl =
//       'https://pronunciation-assessment.vercel.app/api/assessment'; // API URL을 실제로 사용 중인 URL로 변경하세요
//   final AudioRecorder audioRecorder = AudioRecorder();

//   final record = AudioRecorder();

//   String? recordingPath;
//   bool isRecording = false;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     // 여기서 context를 저장해도 안전하게 사용할 수 있습니다.
//   }

//   // final AudioPlayer _audioPlayer = AudioPlayer();

//   Future<void> fetchAndSendAudio() async {
//     String filePath = recordingPath!;
//     File file = File(filePath);

//     if (await file.exists()) {
//       // print("exit");
//       final extension = p.extension(filePath);
//       print(extension);
//       //  await _audioPlayer.play(DeviceFileSource(filePath));

//       try {
//         List<int> fileBytes = await file.readAsBytes();
//         String base64Audio = base64Encode(fileBytes);

//         // API 요청 준비
//         final response = await http.post(
//           Uri.parse(apiUrl),
//           headers: {'Content-Type': 'application/json'},
//           body: jsonEncode({'audio': base64Audio}),
//         );

//         // final request = http.Request('POST', Uri.parse(apiUrl))
//         //   ..headers['Content-Type'] = 'application/json';

//         // final response = await http.get(Uri.parse(apiUrl));
//         // final audioBytes = response.bodyBytes;
//         // final base64Audio = base64Encode(audioBytes);

//         // request.body = jsonEncode({'audio': base64Audio});

//         // final apiResponse =
//         //     await http.Response.fromStream(await request.send());

//         if (response.statusCode == 200) {
//           final responseData = jsonDecode(response.body);
//           print('API Response: $responseData');
//           // // 여기서 화면을 전환할 때는 이 작업이 완료된 후에 수행하는 것이 좋습니다.
//           // if (mounted) {
//           //   // 위젯이 활성 상태일 때만 상태 변경
//           //   Navigator.pushNamed(context, '/your-next-route'); // 다음 화면으로 이동
//           // }
//         } else {
//           print('Failed to send audio. Status code: ${response.statusCode}');
//         }
//       } catch (e) {
//         print('Error: $e');
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: buildUI(),
//     );
//   }

//   Widget buildUI() {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Pronunciation Assessment',
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(Sizes.size40),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 '나는 오늘 학교에 감',
//                 style: Fonts.titleMedium,
//               ),
//               if (recordingPath != null)
//                 GestureDetector(
//                   onTap: fetchAndSendAudio,
//                   child: const Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Text(
//                           'Start Asssessment',
//                           style: Fonts.titleSmall,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               if (recordingPath == null)
//                 FloatingActionButton(
//                   onPressed: () async {
//                     if (isRecording) {
//                       String? filePath = await audioRecorder.stop();
//                       if (filePath != null) {
//                         setState(() {
//                           isRecording = false;
//                           recordingPath = filePath;
//                         });
//                       }
//                     } else {
//                       if (await audioRecorder.hasPermission()) {
//                         final Directory appDocumentDir =
//                             await getApplicationDocumentsDirectory();
//                         final String filePath =
//                             p.join(appDocumentDir.path, "recording.wav");
//                         await audioRecorder.start(
//                             const RecordConfig(
//                               encoder: AudioEncoder.wav, // WAV 형식을 명시적으로 지정
//                               sampleRate: 16000, // 16kHz 샘플 레이트
//                               bitRate: 128000, // 16khz
//                             ),
//                             path: filePath);
//                         setState(() {
//                           isRecording = true;
//                           recordingPath = null;
//                         });
//                       }
//                     }
//                   },
//                   child: Icon(
//                     isRecording
//                         ? FontAwesomeIcons.lightbulb
//                         : FontAwesomeIcons.microphone,
//                   ),
//                 )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

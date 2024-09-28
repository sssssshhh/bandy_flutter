// import 'package:bandy_flutter/constants/cloudFrontPath.dart';
// import 'package:bandy_flutter/constants/gaps.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class Lecture extends StatefulWidget {
//   final String category;
//   final String level;
//   final int lessonNo;
//   final Map<String, dynamic> lecture;

//   const Lecture(
//       {super.key,
//       required this.category,
//       required this.level,
//       required this.lecture,
//       required this.lessonNo});

//   @override
//   State<Lecture> createState() => _LectureState();
// }

// class _LectureState extends State<Lecture> {
//   late VideoPlayerController _videoPlayerController;
//   bool _isPaused = true;
//   bool _isInitialized = false;

//   @override
//   void initState() {
//     super.initState();
//     _initializeVideoPlayer();
//   }

//   void _initializeVideoPlayer() {
//     _videoPlayerController = VideoPlayerController.network(
//       widget.lecture['masterVideoPath'],
//     )..initialize().then((_) {
//         setState(() {
//           _isInitialized = true;
//           _videoPlayerController.pause();
//         });
//       }).catchError((error) {
//         print('Error initializing video player: $error');
//       });
//   }

//   void _loadVideoAtIndex(int index) {
//     setState(() {
//       _isInitialized = false;
//     });

//     _videoPlayerController.dispose(); // Dispose of the previous controller
//     _initializeVideoPlayer(); // Initialize a new controller with the new index
//   }

//   @override
//   void dispose() {
//     _videoPlayerController.dispose();
//     super.dispose();
//   }

//   void _onTogglePause() {
//     if (!_isInitialized) return;

//     if (_videoPlayerController.value.isPlaying) {
//       _videoPlayerController.pause();
//     } else {
//       _videoPlayerController.play();
//     }
//     setState(() {
//       _isPaused = !_isPaused;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.category,
//         ),
//       ),
//       body: Column(
//         children: [
//           SizedBox(
//             height: 250,
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 _isInitialized
//                     ? GestureDetector(
//                         onTap: _onTogglePause,
//                         child: VideoPlayer(_videoPlayerController),
//                       )
//                     : Container(
//                         color: Colors.grey,
//                         child: const Center(child: CircularProgressIndicator()),
//                       ),
//                 _isInitialized
//                     ? IconButton(
//                         iconSize: 64.0,
//                         icon: Icon(
//                           _isPaused ? Icons.play_arrow : Icons.pause,
//                           color: Colors.grey,
//                         ),
//                         onPressed: _onTogglePause,
//                       )
//                     : const SizedBox.shrink(),
//               ],
//             ),
//           ),
//           Gaps.v10,
//           SizedBox(
//             width: double.infinity,
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 4, horizontal: 10), // 타원형 크기 조정
//                     decoration: BoxDecoration(
//                       color: Colors.amber[100],
//                       borderRadius: BorderRadius.circular(5), // 타원형을 위한 경계 반지름
//                     ),
//                     child: Text(
//                       'lesson ${widget.lessonNo}',
//                       style: TextStyle(
//                         fontSize: 10,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.orange[500],
//                       ),
//                     ),
//                   ),
//                   Gaps.v10,
//                   Text(
//                     widget.lecture['title'],
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


//           // Expanded(
//           //   flex: 1,
//           //   child: SingleChildScrollView(
//           //     child: Container(
//           //       padding: const EdgeInsets.all(16.0),
//           //       color: Colors.white,
//           //       child: Column(
//           //         children: List.generate(
//           //           10, // TODO: magic number
//           //           (index) => GestureDetector(
//           //             onTap: () => _loadVideoAtIndex(index),
//           //             child: Padding(
//           //               padding: const EdgeInsets.all(3.0),
//           //               child: Row(
//           //                 mainAxisAlignment: MainAxisAlignment.start,
//           //                 children: [
//           //                   Container(
//           //                     width: 130,
//           //                     height: 100,
//           //                     decoration: BoxDecoration(
//           //                       borderRadius: BorderRadius.circular(8.0),
//           //                       border: Border.all(color: Colors.grey),
//           //                       image: DecorationImage(
//           //                         image: NetworkImage(
//           //                           '${Cloudfrontpath.Domain}/${widget.category}/${widget.level}/thumbnail/lv1_${index + 1}.png',
//           //                         ),
//           //                         fit: BoxFit.cover,
//           //                       ),
//           //                     ),
//           //                   ),
//           //                   Gaps.h12,
//           //                   Expanded(
//           //                     child: Text(
//           //                       'Lecture ${index + 1}',
//           //                       style: const TextStyle(
//           //                         fontWeight: FontWeight.bold,
//           //                         fontSize: 16,
//           //                         color: Colors.orange,
//           //                       ),
//           //                     ),
//           //                   ),
//           //                 ],
//           //               ),
//           //             ),
//           //           ),
//           //         ),
//           //       ),
//           //     ),
//           //   ),
//           // ),
import 'dart:math';

import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/pages/lectures/listen_speak.dart';
import 'package:bandy_flutter/pages/lectures/puzzle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Progress extends StatefulWidget {
  final String progressStatus;
  final String category;
  final String level;
  final int lessonNo;

  const Progress({
    super.key,
    required this.progressStatus,
    required this.category,
    required this.level,
    required this.lessonNo,
  });

  @override
  State<Progress> createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  @override
  Widget build(BuildContext context) {
    double progressValue = double.parse(widget.progressStatus) / 100;

    String speakWithAI = 'Speak with AI';
    String sentenceTest = 'Sentence Test';

    return LayoutBuilder(builder: (BuildContext context, BoxConstraints viewportConstraints) {
      final detailButtonWidth = max((viewportConstraints.maxWidth - 60), 0) * 0.5; // - 값은 패딩

      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Progress: ${widget.progressStatus}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Stack(
                alignment: Alignment.centerLeft,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Container(
                      height: 10.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[300], // 배경색
                      ),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: progressValue,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.yellow, Colors.orange], // 그라데이션 색상
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Gaps.v60,
              const Text('Details',
                  style: TextStyle(
                      fontSize: 16, color: Color(0xFF444444), fontWeight: FontWeight.w500)),
              Gaps.v16,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DetailButton(
                    moveto: speakWithAI,
                    iconName: 'speak_with_ai',
                    category: widget.category,
                    level: widget.level,
                    lessonNo: widget.lessonNo,
                    width: detailButtonWidth,
                  ),
                  const SizedBox(width: 20),
                  DetailButton(
                    moveto: sentenceTest,
                    iconName: 'sentence_test',
                    category: widget.category,
                    level: widget.level,
                    lessonNo: widget.lessonNo,
                    width: detailButtonWidth,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}

class DetailButton extends StatefulWidget {
  final String moveto;
  final String iconName;
  final String category;
  final String level;
  final int lessonNo;
  final double width;

  const DetailButton({
    super.key,
    required this.moveto,
    required this.iconName,
    required this.category,
    required this.level,
    required this.lessonNo,
    required this.width,
  });

  @override
  State<DetailButton> createState() => _DetailButtonState();
}

class _DetailButtonState extends State<DetailButton> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  List<Map<String, dynamic>> expressionList = [];

  @override
  void initState() {
    super.initState();

    _getExpressionInfo();
  }

  Future<void> _getExpressionInfo() async {
    final dbs = await _db
        .collection('lectures')
        .doc(widget.category)
        .collection(widget.level)
        .doc(widget.lessonNo.toString())
        .collection('expression')
        .get();

    setState(() {
      expressionList = dbs.docs.map((doc) => doc.data()).toList();
    });
  }

  void _onNextTap(BuildContext context, String destination, int lessonNo) {
    if (destination == 'Speak with AI') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListenSpeak(
            expressionList: expressionList,
            lessonNo: lessonNo,
            level: widget.level,
            category: widget.category,
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Puzzle(
            expressionList: expressionList,
            lessonNo: lessonNo,
            level: widget.level,
            category: widget.category,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = min(widget.width, 200);
    final double height = min(widget.width * 0.75, 150);

    return GestureDetector(
      onTap: () => _onNextTap(context, widget.moveto, widget.lessonNo),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/svg/${widget.iconName}.svg'),
            Gaps.v8,
            Text(widget.moveto, style: const TextStyle(fontSize: 12, color: Color(0xFF808080))),
            Gaps.v8,
            Container(
              width: 90,
              height: 34,
              decoration: BoxDecoration(
                color: const Color(0xFFF2BC40),
                borderRadius: BorderRadius.circular(45),
              ),
              // onPressed: () {
              //   _onNextTap(context, widget.moveto, widget.lessonNo);
              // },
              child: const Center(
                  child: Text('Start', style: TextStyle(fontSize: 16, color: Colors.white))),
            ),
          ],
        ),
      ),
    );
  }
}

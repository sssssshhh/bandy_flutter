import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/pages/lectures/listen_speak.dart';
import 'package:bandy_flutter/pages/lectures/puzzle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
    return Padding(
      padding: const EdgeInsets.all(34.0),
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
          const SizedBox(height: 20),
          const Text('Details'),
          Gaps.v10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Details(
                  moveto: speakWithAI,
                  category: widget.category,
                  level: widget.level,
                  lessonNo: widget.lessonNo),
              Details(
                  moveto: sentenceTest,
                  category: widget.category,
                  level: widget.level,
                  lessonNo: widget.lessonNo),
            ],
          ),
        ],
      ),
    );
  }
}

class Details extends StatefulWidget {
  final String moveto;
  final String category;
  final String level;
  final int lessonNo;

  const Details({
    super.key,
    required this.moveto,
    required this.category,
    required this.level,
    required this.lessonNo,
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
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
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: 160,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(widget.moveto, style: const TextStyle(fontSize: 12)),
          Gaps.v40,
          ElevatedButton(
            onPressed: () {
              _onNextTap(context, widget.moveto, widget.lessonNo);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              fixedSize: const Size(90, 20),
            ),
            child: const Text('start'),
          ),
        ],
      ),
    );
  }
}

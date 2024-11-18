import 'dart:convert';

import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/constants/bandy.dart';
import 'package:bandy_flutter/pages/authentication/widget/form_button.dart';
import 'package:bandy_flutter/pages/lectures/main_navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PronunciationAssessmentResults extends StatefulWidget {
  final String fileName;
  final String korAnswer;
  final int lessonNo;
  final String level;
  final String category;

  const PronunciationAssessmentResults({
    super.key,
    required this.fileName,
    required this.korAnswer,
    required this.lessonNo,
    required this.level,
    required this.category,
  });

  @override
  State<PronunciationAssessmentResults> createState() =>
      _PronunciationAssessmentResultsState();
}

class _PronunciationAssessmentResultsState
    extends State<PronunciationAssessmentResults> {
  String apiUrl = 'https://pronunciation-assessment.vercel.app/api/assessment';
  String accuracyScore = "0";

  @override
  void initState() {
    super.initState();
    getAssessmentResult();
  }

  Future<void> _onNextTap() async {
    await setStatus();

    Navigator.pushNamedAndRemoveUntil(
        context, MainNavigation.routeName, (route) => false);
  }

  Future<void> setStatus() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser?.email != null) {
      final dbs = await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser!.email)
          .collection("completedLectures")
          .doc(widget.level)
          .get();

      final completedLectures = dbs.data()?[widget.category] as String;
      final completedLectureList = completedLectures.split(',');

      if (!completedLectureList.contains(widget.lessonNo.toString())) {
        // confused 30 +  bitestory 30 + podcast 30 + 10 = 100
        var status = dbs.data()?['status'] + 3;
        if (status == 90) {
          status = 100;
          levelup();
        }

        completedLectureList.add(widget.lessonNo.toString());

        await FirebaseFirestore.instance
            .collection('users')
            .doc(auth.currentUser!.email)
            .collection("completedLectures")
            .doc(widget.level)
            .update({
          'status': status,
          widget.category: completedLectureList.isEmpty
              ? completedLectureList.join("")
              : completedLectureList.join(",")
        });
      }
    }
  }

  Future<void> levelup() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    var level = "";
    switch (widget.level) {
      case Bandy.level1:
        level = Bandy.level2;
      case Bandy.level2:
        level = Bandy.level3;
      default:
        level = Bandy.level3;
    }

    FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.email)
        .update({'level': level});
  }

  Future<void> getAssessmentResult() async {
    try {
      final Map<String, String> requestData = {
        'fileName': widget.fileName,
        'referenceText': widget.korAnswer
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(requestData),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          accuracyScore = data['accuracyScore'].toString();
        });
      } else {
        print(
            'Failed to load pronunciation assessment: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 40.0,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Pronunciation Assessment Results",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 400,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Center(
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.orange, width: 8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          accuracyScore,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "Excellent!",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Gaps.v80,
              GestureDetector(
                onTap: _onNextTap,
                child: const FormButton(
                  text: 'Check',
                  disabled: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

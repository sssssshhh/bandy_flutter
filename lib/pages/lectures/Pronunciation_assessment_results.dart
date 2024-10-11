import 'dart:convert';

import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/pages/authentication/widget/form_button.dart';
import 'package:bandy_flutter/pages/lectures/lectures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PronunciationAssessmentResults extends StatefulWidget {
  final String fileName;
  final String korAnswer;

  const PronunciationAssessmentResults({
    super.key,
    required this.fileName,
    required this.korAnswer,
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

  void _onNextTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Lectures(),
      ),
    );
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

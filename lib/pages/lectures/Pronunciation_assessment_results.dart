import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/pages/authentication/widget/form_button.dart';
import 'package:bandy_flutter/pages/lectures/lectures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PronunciationAssessmentResults extends StatefulWidget {
  const PronunciationAssessmentResults({super.key});

  @override
  State<PronunciationAssessmentResults> createState() =>
      _PronunciationAssessmentResultsState();
}

class _PronunciationAssessmentResultsState
    extends State<PronunciationAssessmentResults> {
  @override
  void initState() {
    super.initState();
  }

  void _onNextTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Lectures(),
      ),
    );
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
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "100",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
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
              // Check 버튼 위에 텍스트 추가
              const Text(
                "The pronunciation assessment service will be opening soon!",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Gaps.v16,
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

import 'package:bandy_flutter/constants/bandy.dart';
import 'package:bandy_flutter/constants/fonts.dart';
import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/constants/sizes.dart';
import 'package:bandy_flutter/pages/authentication/widget/form_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Puzzle extends StatefulWidget {
  final String category;
  final String level;
  final int lessonNo;

  const Puzzle({
    super.key,
    required this.category,
    required this.level,
    required this.lessonNo,
  });

  @override
  State<Puzzle> createState() => _PuzzleState();
}

class _PuzzleState extends State<Puzzle> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final List<int> _selectedIndices = [];
  final List<String> _selectedCharacters = [];
  final answer = '가나다라';
  bool isChecked = false;
  bool _isCorrectAnswer = false;

  List<Map<String, dynamic>> expressionList = [];
  int? _startIndex; // 시작 인덱스 저장
  int? _endIndex; // 끝 인덱스 저장

  @override
  void initState() {
    super.initState();
    getExpressionInfo();
  }

  Future<void> getExpressionInfo() async {
    final QuerySnapshot<Map<String, dynamic>> dbs = await _db
        .collection('lectures')
        .doc(widget.category)
        .collection(widget.level)
        .doc("1") // TODO: widget.lessonNo.toString()
        .collection('expression')
        .get();

    setState(() {
      expressionList = dbs.docs.map((doc) => doc.data()).toList();
    });
    print(expressionList);
  }

  bool checkAnswer() {
    String selectedCharacters = _selectedCharacters.join();
    _isCorrectAnswer = answer == selectedCharacters;
    return _isCorrectAnswer;
  }

  void _handleButtonPress() {
    setState(() {
      if (isChecked) {
        // Reset the state if the answer was checked
        _selectedIndices.clear();
        _selectedCharacters.clear();
        _startIndex = null; // 시작 인덱스 초기화
        _endIndex = null; // 끝 인덱스 초기화
        isChecked = false;
      } else {
        // Check the answer and update the state
        checkAnswer();
        isChecked = true;
      }
    });
  }

  String maskKorAnswer(String korAnswer, int firstBlank, int lastBlank) {
    String prefix = korAnswer.substring(0, firstBlank);
    String suffix = korAnswer.substring(lastBlank + 1);
    String masked = '$prefix${'?' * (lastBlank - firstBlank + 1)}$suffix';
    return masked;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v40,
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Complete the puzzles',
                  style: Fonts.titleLarge,
                ),
                Text(
                  'Connect the words to make a sentence then tap to check the answer.',
                  style: Fonts.titleSmall,
                ),
              ],
            ),
            Gaps.v20,
            Container(
              width: double.infinity,
              height: 100,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: expressionList.isNotEmpty
                              ? expressionList[0]['korAnswer']
                                  .substring(0, expressionList[0]['firstBlank'])
                              : '',
                        ),
                        WidgetSpan(
                          child: Container(
                            color: Colors.grey[300],
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Text(
                              expressionList.isNotEmpty
                                  ? '?' *
                                      (expressionList[0]['lastBlank'] -
                                          expressionList[0]['firstBlank'] +
                                          1)
                                  : '',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        TextSpan(
                          text: expressionList.isNotEmpty
                              ? expressionList[0]['korAnswer']
                                  .substring(expressionList[0]['lastBlank'] + 1)
                              : '',
                        ),
                      ],
                    ),
                  ),
                  Text(
                    expressionList.isNotEmpty
                        ? expressionList[0]['engAnswer']
                        : '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Gaps.v20,
            SizedBox(
              height: 400, // 고정 높이 설정
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                  childAspectRatio: 1.2,
                ),
                itemCount: 16,
                itemBuilder: (context, index) {
                  final characters = [
                    '가',
                    '나',
                    '다',
                    '라',
                    '마',
                    '사',
                    '아',
                    '자',
                    '차',
                    '카',
                    '타',
                    '파',
                    '하',
                    '라',
                    '마',
                    '바',
                  ];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_selectedIndices.contains(index)) {
                          _selectedIndices.remove(index);
                          _selectedCharacters.remove(characters[index]);
                          if (_startIndex == index) {
                            _startIndex = null;
                          }
                          if (_endIndex == index) {
                            _endIndex = null;
                          }
                        } else {
                          _selectedIndices.add(index);
                          _selectedCharacters.add(characters[index]);
                          if (_startIndex == null) {
                            _startIndex = index; // 첫 번째 클릭
                          } else {
                            _endIndex = index; // 두 번째 클릭
                          }
                        }
                      });
                    },
                    child: Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _selectedIndices.contains(index)
                                  ? Colors.orange
                                  : Colors.grey,
                              width:
                                  _selectedIndices.contains(index) ? 2.0 : 1.0,
                            ),
                          ),
                          child: Text(
                            characters[index],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (_startIndex == index)
                          Positioned(
                            left: 20,
                            top: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'start',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),
                        if (_endIndex == index)
                          Positioned(
                            left: 20,
                            top: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'end',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Gaps.v20,
            GestureDetector(
              onTap: _handleButtonPress,
              child: FormButton(
                text: 'Check',
                disabled: _selectedCharacters.isEmpty,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:math';
import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/constants/hangul.dart';
import 'package:bandy_flutter/constants/sizes.dart';
import 'package:bandy_flutter/pages/authentication/widget/form_button.dart';
import 'package:bandy_flutter/pages/lectures/completed.dart';
import 'package:flutter/material.dart';

class Puzzle extends StatefulWidget {
  final List<Map<String, dynamic>> expressionList;
  final int lessonNo;
  final String level;
  final String category;

  const Puzzle({
    super.key,
    required this.expressionList,
    required this.lessonNo,
    required this.level,
    required this.category,
  });

  @override
  State<Puzzle> createState() => _PuzzleState();
}

class _PuzzleState extends State<Puzzle> {
  final List<int> _selectedIndices = [];
  final List<String> _selectedCharacters = [];
  bool isChecked = false;
  bool _showAnswerOverlay = false;
  bool _isCorrectAnswer = false;

  String answer = '';
  int? _startIndex;
  int? _endIndex;

  final Random _random = Random();
  final List<String> characters = [];
  String maskedKorAnswer = '';

  int circleCount = 16;

  @override
  void initState() {
    super.initState();
    getExpressionInfo();
  }

  Future<void> getExpressionInfo() async {
    setState(() {
      String korAnswer = widget.expressionList[0]['korAnswer'] ?? '';
      int firstBlank = widget.expressionList[0]['firstBlank'] ?? 0;
      int lastBlank = widget.expressionList[0]['lastBlank'] ?? 0;

      maskedKorAnswer = korAnswer.replaceRange(
        firstBlank,
        lastBlank + 1,
        '?' * (lastBlank - firstBlank + 1),
      );
      if (widget.expressionList.isEmpty) {
        answer = '';
      } else {
        answer = widget.expressionList[0]['answer'] ?? '';
      }

      const characterOptions = Hangul.Hanguls;

      characters.clear();

      if (answer.isNotEmpty) {
        characters.addAll(answer.split(''));
      }

      int remainingCount = circleCount - characters.length;

      if (remainingCount > 0) {
        characters.addAll(
          List.generate(
            remainingCount,
            (index) => characterOptions[_random.nextInt(characterOptions.length)],
          ),
        );
        characters.shuffle();
      }
    });
  }

  void checkAnswer() {
    String korAnswer = widget.expressionList[0]['korAnswer'];
    int firstBlank = widget.expressionList[0]['firstBlank'];
    int lastBlank = widget.expressionList[0]['lastBlank'];

    // '?' 부분에 _selectedCharacters를 대입
    String filledAnswer = korAnswer.substring(0, firstBlank) +
        _selectedCharacters.join() +
        korAnswer.substring(lastBlank + 1);

    setState(() {
      _isCorrectAnswer = filledAnswer == korAnswer;
    });
  }

  void _handleButtonPress() {
    setState(() {
      if (isChecked) {
        // Reset the state if the answer was checked
        _selectedIndices.clear();
        _selectedCharacters.clear();
        _startIndex = null;
        _endIndex = null;
        isChecked = false;
        _showAnswerOverlay = false;
      } else {
        // Check the answer and update the state
        _showAnswerOverlay = true;
        isChecked = true;
      }
      checkAnswer();
    });
  }

  void _onNextTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Completed(
          expressionList: widget.expressionList,
          lessonNo: widget.lessonNo,
          level: widget.level,
          category: widget.category,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          LayoutBuilder(builder: (BuildContext context, BoxConstraints viewportConstraints) {
            final double maxWidth = viewportConstraints.maxWidth;
            final double titleFontSize = min(maxWidth * 0.065, 40);
            final double subTitleFontSize = min(maxWidth * 0.038, 18);

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size24, vertical: 30),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Complete the puzzles',
                            style: TextStyle(
                                fontSize: titleFontSize,
                                color: const Color(0xFF1A1A1A),
                                fontWeight: FontWeight.bold),
                          ),
                          Gaps.v10,
                          Text(
                            'Connect the words to make a sentence then tap to check the answer.',
                            style: TextStyle(
                                fontSize: subTitleFontSize, color: const Color(0xFF808080)),
                          ),
                        ],
                      ),
                      Gaps.v20,
                      _buildQuestion(maxWidth: maxWidth),
                      Gaps.v32,
                      _buildPuzzleBoard(maxWidth: maxWidth),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: _handleButtonPress,
                        child: FormButton(
                          text: 'Check',
                          disabled: _selectedCharacters.isEmpty,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
          if (_showAnswerOverlay)
            Stack(
              children: [
                Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    // 상단 타원형
                    Positioned.fill(
                      child: Align(
                        alignment: const Alignment(0.0, -0.55), // 화면 중앙 위쪽
                        child: Container(
                          width: 300,
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.expressionList.isNotEmpty
                                    ? widget.expressionList[0]['korAnswer']
                                    : '',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // 하단 타원형
                    Positioned.fill(
                      child: Align(
                        alignment: const Alignment(0.0, 0.99), // 화면 하단
                        child: Container(
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          width: double.infinity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  color: _isCorrectAnswer ? Colors.blue : Colors.red,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      _isCorrectAnswer ? Icons.check : Icons.close,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 8.0),
                                    Text(
                                      _isCorrectAnswer ? 'Correct' : 'Incorrect',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Gaps.v20,
                              Text(
                                widget.expressionList.isNotEmpty
                                    ? widget.expressionList[0]['engAnswer']
                                    : '',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                widget.expressionList.isNotEmpty
                                    ? widget.expressionList[0]['korAnswer']
                                    : '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20), // 버튼을 위한 공간 추가
                              GestureDetector(
                                onTap: _onNextTap,
                                child: FormButton(
                                  text: _isCorrectAnswer ? 'Continue' : 'Got it',
                                  disabled: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
        ],
      ),
    );
  }

  Widget _buildQuestion({required double maxWidth}) {
    final double questionKorFontSize = min(maxWidth * 0.075, 50);
    final double questionEngFontSize = min(maxWidth * 0.038, 25);

    return Container(
      width: double.infinity,
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
              style: TextStyle(
                  fontSize: questionKorFontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1A1A)),
              children: [
                TextSpan(
                  text: widget.expressionList.isNotEmpty
                      ? widget.expressionList[0]['korAnswer']
                          .substring(0, widget.expressionList[0]['firstBlank'])
                      : '',
                ),
                WidgetSpan(
                  child: Container(
                    color: const Color(0xFFF0F0F0),
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(
                      widget.expressionList.isNotEmpty
                          ? '?' *
                              (widget.expressionList[0]['lastBlank'] -
                                  widget.expressionList[0]['firstBlank'] +
                                  1)
                          : '',
                      style: TextStyle(
                        fontSize: questionKorFontSize,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFBEBEBE),
                      ),
                    ),
                  ),
                ),
                TextSpan(
                  text: widget.expressionList.isNotEmpty
                      ? widget.expressionList[0]['korAnswer']
                          .substring(widget.expressionList[0]['lastBlank'] + 1)
                      : '',
                  style: TextStyle(
                    fontSize: questionKorFontSize,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
              ],
            ),
          ),
          Text(
            widget.expressionList.isNotEmpty ? widget.expressionList[0]['engAnswer'] : '',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: questionEngFontSize, color: const Color(0xFF808080)),
          ),
        ],
      ),
    );
  }

  Widget _buildPuzzleBoard({required double maxWidth}) {
    final double width = maxWidth * 0.75;
    final double puzzleFontSize = maxWidth * 0.055;

    return Center(
      child: SizedBox(
        width: width,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 5,
            mainAxisSpacing: 25,
            childAspectRatio: 1.2,
          ),
          itemCount: circleCount,
          itemBuilder: (context, index) {
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
                      _startIndex = index; // first click
                    } else {
                      _endIndex = index; // second click
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
                            ? const Color(0xFFF2BC40)
                            : const Color(0xFFEAEAEA),
                        width: _selectedIndices.contains(index) ? 2.0 : 1.0,
                      ),
                    ),
                    child: Text(
                      characters[index],
                      style: TextStyle(
                        color: const Color(0xFF444444),
                        fontSize: puzzleFontSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (_startIndex == index)
                    Positioned(
                      left: 20,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'start',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  if (_endIndex == index)
                    Positioned(
                      left: 20,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'end',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

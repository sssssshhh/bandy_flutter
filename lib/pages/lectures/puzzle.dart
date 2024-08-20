import 'package:bandy_flutter/constants/fonts.dart';
import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/constants/sizes.dart';
import 'package:bandy_flutter/pages/authentication/widget/form_button.dart';
import 'package:flutter/material.dart';

class Puzzle extends StatefulWidget {
  const Puzzle({super.key});

  @override
  State<Puzzle> createState() => _PuzzleState();
}

class _PuzzleState extends State<Puzzle> {
  final List<int> _selectedIndices = [];
  final List<String> _selectedCharacters = [];
  final answer = '가나다라';
  bool isChecked = false;
  bool _isCorrectAnswer = false;

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
        isChecked = false;
      } else {
        // Check the answer and update the state
        checkAnswer();
        isChecked = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

            // Display selected characters above the grid
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _selectedCharacters.length,
                itemBuilder: (context, index) {
                  return Text(
                    _selectedCharacters[index],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  );
                },
              ),
            ),

            // GridView
            Expanded(
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
                        } else {
                          _selectedIndices.add(index);
                          _selectedCharacters.add(characters[index]);
                        }
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _selectedIndices.contains(index)
                            ? Colors.grey
                            : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey, width: 1.0),
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
                  );
                },
              ),
            ),
            Gaps.v16,

            // Display additional messages based on isChecked and _isCorrectAnswer
            if (isChecked) ...[
              // Display message based on the result of checkAnswer
              Text(
                _isCorrectAnswer ? 'You did a great job!' : 'Answer is $answer',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Gaps.v16,
            ],

            // Check 버튼
            GestureDetector(
              onTap: _handleButtonPress,
              child: FormButton(
                text: isChecked
                    ? (_isCorrectAnswer ? 'Continue' : 'I got it')
                    : 'Check',
                disabled: _selectedCharacters.isEmpty,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

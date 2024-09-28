import 'package:bandy_flutter/constants/bandy.dart';
import 'package:bandy_flutter/constants/fonts.dart';
import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/constants/sizes.dart';
import 'package:bandy_flutter/pages/authentication/view_model/signup_view_model.dart';
import 'package:bandy_flutter/pages/authentication/widget/form_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectLevel extends ConsumerStatefulWidget {
  const SelectLevel({super.key});

  @override
  ConsumerState<SelectLevel> createState() => _SelectLevelState();
}

class _SelectLevelState extends ConsumerState<SelectLevel> {
  String _selectedLevel = "";

  void _onNextTap() {
    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {
      ...state,
      "level": _selectedLevel,
    };
    ref.read(signUpProvider.notifier).signUp(context);
  }

  void _selectLevel(String level) {
    setState(() {
      _selectedLevel = level;
    });
  }

  Widget _levelOption(String level) {
    final bool isSelected = _selectedLevel == level;
    IconData icon;
    String topText;
    String middleText;
    String bottomText;

    switch (level) {
      case 'A2':
        icon = Icons.query_builder_sharp;
        topText = '2';
        middleText = "Low Pre-intermediate (A2)";
        bottomText = "I can understand short texts on everyday topics.";
        break;
      case 'A3':
        icon = Icons.account_balance_sharp;
        topText = '3';
        middleText = "High Pre-intermediate (A2)";
        bottomText =
            "I can understand moderately sized texts on various aspects of daily life.";
        break;
      default: // 'level1'
        icon = Icons.cruelty_free;
        topText = '1';
        middleText = "High Pre-intermediate (A3)";
        bottomText = "I can understand words and very simple sentences.";

        break;
    }

    return GestureDetector(
      onTap: () => _selectLevel(level),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        margin: const EdgeInsets.symmetric(vertical: 8),
        height: 150,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.grey[200],
          border: Border.all(
            color: isSelected ? Colors.yellow : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 190,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Level ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.black : Colors.grey[800],
                        ),
                      ),
                      Text(
                        topText,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    middleText,
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected ? Colors.black : Colors.grey[800],
                    ),
                  ),
                  Gaps.v14,
                  Text(
                    bottomText,
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? Colors.black : Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  icon,
                  size: 40,
                  color: Colors.lime,
                ),
                if (isSelected)
                  const Positioned(
                    right: -5,
                    top: -5,
                    child: Icon(
                      Icons.check,
                      color: Colors.orange,
                      size: 34,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Sign up",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size36,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Gaps.v40,
            const Text(
              "What’s your level?",
              style: Fonts.titleLarge,
            ),
            const Text(
              'Select your level.',
              style: Fonts.titleSmall,
            ),
            Gaps.v20,
            _levelOption(Bandy.level1),
            _levelOption(Bandy.level2),
            _levelOption(Bandy.level3),
            Gaps.v16,
            GestureDetector(
              onTap: _onNextTap,
              child: FormButton(
                text: 'Continue',
                disabled: _selectedLevel.isEmpty,
              ),
            ),
          ]),
        ));
  }
}

import 'package:bandy_flutter/constants/bandy.dart';
import 'package:bandy_flutter/constants/fonts.dart';
import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/constants/sizes.dart';
import 'package:bandy_flutter/pages/authentication/view_model/signup_view_model.dart';
import 'package:bandy_flutter/pages/authentication/widget/form_button.dart';
import 'package:bandy_flutter/pages/lectures/main_navigation.dart';
import 'package:bandy_flutter/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class SelectLevel extends ConsumerStatefulWidget {
  static const routeName = "/select-level";

  final bool canSelect;
  final String initialLevel;

  const SelectLevel({
    super.key,
    required this.canSelect,
    this.initialLevel = '',
  });

  @override
  ConsumerState<SelectLevel> createState() => _SelectLevelState();
}

class _SelectLevelState extends ConsumerState<SelectLevel> {
  String _selectedLevel = '';

  @override
  void initState() {
    super.initState();

    if (widget.initialLevel.isNotEmpty) {
      _selectLevel(widget.initialLevel);
    }
  }

  void _onNextTap() async {
    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {
      ...state,
      "level": _selectedLevel,
    };

    final result = await ref.read(signUpProvider.notifier).signUp();

    if (!mounted) return;

    if (result.hasError) {
      showFirebaseErrorSnack(context, result.error);
    } else {
      Navigator.pushNamed(context, MainNavigation.routeName);
    }
  }

  void _selectLevel(String level) {
    setState(() {
      _selectedLevel = level;
    });
  }

  Widget _levelOption(String level) {
    final bool isSelected = _selectedLevel == level;
    String iconAssetName;
    String topText;
    String middleText;
    String bottomText;

    switch (level) {
      case 'level1': // 'level1'
        iconAssetName = 'level_1';
        topText = '1';
        middleText = "High Beginner (A1)";
        bottomText = "I can understand words and very simple sentences.";
        break;
      case 'level2': // 'level2'
        iconAssetName = 'level_2';
        topText = '2';
        middleText = "Low Pre-intermediate (A2)";
        bottomText = "I can understand short texts on everyday topics.";
        break;
      default: // 'level3'
        iconAssetName = 'level_3';
        topText = '3';
        middleText = "High Pre-intermediate (A2)";
        bottomText = "I can understand moderately sized texts on various aspects of daily life.";
        break;
    }

    return GestureDetector(
      onTap: () {
        if (widget.canSelect) {
          _selectLevel(level);
        }
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            margin: const EdgeInsets.symmetric(vertical: 8),
            height: 150,
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.grey[200],
              border: isSelected
                  ? const GradientBoxBorder(
                      gradient: LinearGradient(
                        colors: [Color(0xFFFFE55B), Color(0xFFF2BC40), Color(0xFFFFA63F)],
                      ),
                      width: 2,
                    )
                  : null,
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
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected ? const Color(0xFFF7F7F7) : Colors.white,
                      ),
                    ),
                    SvgPicture.asset('assets/svg/$iconAssetName.svg'),
                    if (isSelected)
                      Positioned(
                        right: -5,
                        top: -5,
                        child: SvgPicture.asset('assets/svg/level_checkbox.svg'),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.canSelect ? 'What’s your level?' : 'My level';
    final subTitle = widget.canSelect ? 'Select your level.' : '';

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size36,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Gaps.v40,
          Text(
            title,
            style: Fonts.titleLarge,
          ),
          Text(
            subTitle,
            style: Fonts.titleSmall,
          ),
          Gaps.v20,
          _levelOption(Bandy.level1),
          _levelOption(Bandy.level2),
          _levelOption(Bandy.level3),
          Gaps.v16,
          if (widget.canSelect)
            GestureDetector(
              onTap: _onNextTap,
              child: FormButton(
                text: 'Continue',
                disabled: _selectedLevel.isEmpty,
              ),
            ),
        ]),
      ),
    );
  }
}

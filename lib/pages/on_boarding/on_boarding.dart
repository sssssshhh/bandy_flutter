import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/constants/sizes.dart';
import 'package:bandy_flutter/pages/authentication/sign_up/sign_up_or_sign_in.dart';
import 'package:bandy_flutter/widgets/action_button.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  static const routeName = "/onBoarding";

  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  void _onSignInSignUpTap(BuildContext context) {
    Navigator.pushNamed(context, SignUpOrSignIn.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              const SizedBox(
                height: 56,
                child: TabPageSelector(
                  color: Colors.white,
                  selectedColor: Colors.amber,
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildTabBarView(
                      'https://dlcb5kh12wprc.cloudfront.net/onboarding/1.png',
                      'Develop your reading skills',
                      'Korean stories narrated by an actor',
                    ),
                    _buildTabBarView(
                      'https://dlcb5kh12wprc.cloudfront.net/onboarding/2.png',
                      'Improve your pronunciation',
                      'AI Korean pronunciation practice: listen & repeat',
                    ),
                    _buildTabBarView(
                      'https://dlcb5kh12wprc.cloudfront.net/onboarding/3.png',
                      'Have fun learning with experts',
                      'Lecture clips and puzzles',
                      isNextButton: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBarView(
    String imageUrl,
    String title,
    String subTitle, {
    bool isNextButton = false,
  }) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints viewportConstraints) {
      final imageHeight = viewportConstraints.maxHeight * 0.6;
      final titleFontSize = viewportConstraints.maxHeight * 0.022;
      final subTitleFontSize = viewportConstraints.maxHeight * 0.016;

      return Padding(
        padding: const EdgeInsets.all(Sizes.size20),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: imageHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Gaps.v64,
                Text(
                  title,
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gaps.v10,
                Text(
                  subTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF808080),
                    fontSize: subTitleFontSize,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            if (isNextButton) _buildNextButton()
          ],
        ),
      );
    });
  }

  Widget _buildNextButton() {
    return ActionButton(
      text: 'Get started',
      onPressed: () => _onSignInSignUpTap(context),
    );
  }
}

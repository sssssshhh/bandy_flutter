import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/constants/sizes.dart';
import 'package:bandy_flutter/pages/authentication/sign_up/sign_up_or_sign_in.dart';
import 'package:bandy_flutter/widgets/button.dart';
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(20.0),
            child: TabPageSelector(
              color: Colors.white,
              selectedColor: Colors.amber,
            ),
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.all(Sizes.size40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 260,
                      height: 390,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: const DecorationImage(
                          image: NetworkImage(
                            'https://dlcb5kh12wprc.cloudfront.net/onboarding/1.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Gaps.v64,
                    const Text(
                      'Develop your reading skills',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gaps.v28,
                    const Text(
                      'Korean stories narrated by anactor',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Sizes.size40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 260,
                      height: 390,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: const DecorationImage(
                          image: NetworkImage(
                            'https://dlcb5kh12wprc.cloudfront.net/onboarding/2.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Gaps.v64,
                    const Text(
                      'Improve your pronunciation',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gaps.v28,
                    const Text(
                      'AI Korean pronunciation practice: listen & repeat',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Sizes.size40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 260,
                      height: 390,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: const DecorationImage(
                          image: NetworkImage(
                            'https://dlcb5kh12wprc.cloudfront.net/onboarding/3.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Gaps.v64,
                    const Text(
                      'Have fun learning with experts',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gaps.v28,
                    const Text(
                      'Lecture clips and quizzes',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Gaps.v40,
                    GestureDetector(
                      onTap: () => _onSignInSignUpTap(context),
                      child: const Button(
                        text: 'Get Started',
                        bgColor: Colors.orange, // TODO: Colors.orange[200]
                        textColor: Colors.white,
                      ),
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
}

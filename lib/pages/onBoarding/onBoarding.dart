import 'package:bandy_flutter/constants/sizes.dart';
import 'package:bandy_flutter/pages/authentication/sign_up/sign_up_or_sign_in.dart';
import 'package:bandy_flutter/widgets/button.dart';
import 'package:flutter/material.dart';

class Tutorial extends StatefulWidget {
  const Tutorial({super.key});

  @override
  State<Tutorial> createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {
  void _onSignInSignUpTap(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const SignUpOrSignIn(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: TabBarView(
            children: [
              const Padding(
                padding: EdgeInsets.all(Sizes.size40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Develop your reading skills',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Korean stories narrated by an actor',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(Sizes.size40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Improve your pronunciation',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Practice your pronunciation with AI: listen & repeat',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  Sizes.size20, // Left
                  Sizes.size40, // Top,
                  Sizes.size20, // Right
                  0, // Bottom
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Have fun learning with experts',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Listen to lectures and complete quizzes',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ],
                      ),
                    ),
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
        bottomNavigationBar: const BottomAppBar(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TabPageSelector(
                color: Colors.white,
                selectedColor: Colors.amberAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

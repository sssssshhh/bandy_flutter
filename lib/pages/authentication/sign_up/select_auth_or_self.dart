import 'package:bandy_flutter/constants/fonts.dart';
import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/constants/sizes.dart';
import 'package:bandy_flutter/pages/authentication/widget/auth_button.dart';
import 'package:bandy_flutter/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SelectSignUp extends StatefulWidget {
  const SelectSignUp({super.key});

  @override
  State<SelectSignUp> createState() => _SelectSignUpSignInState();
}

class _SelectSignUpSignInState extends State<SelectSignUp> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.size40,
            vertical: Sizes.size40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign Up',
                      style: Fonts.titleLarge,
                    ),
                    Text(
                      'Lighting Up Your Korean Learning Journey',
                      style: Fonts.titleSmall,
                    ),
                    Gaps.v8,
                    AuthButton(
                      text: 'Continue with Apple',
                      icon: FaIcon(FontAwesomeIcons.apple),
                    ),
                    Gaps.v8,
                    AuthButton(
                      text: 'Continue with Google',
                      icon: FaIcon(FontAwesomeIcons.google),
                    ),
                    Gaps.v8,
                    AuthButton(
                      text: 'Continue with Facebook',
                      icon: FaIcon(FontAwesomeIcons.facebook),
                    ),
                    Gaps.v40,
                    AuthButton(
                      text: 'Or use your email',
                      icon: FaIcon(FontAwesomeIcons.user),
                    ),
                    Gaps.v8,
                    Column(
                      children: [
                        Text(
                          'By signing up, you accept Bandys',
                          textAlign: TextAlign.center,
                        ),
                        Text('Terms of Service and Privacy Policy')
                      ],
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

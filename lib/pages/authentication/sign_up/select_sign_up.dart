import 'package:bandy_flutter/constants/fonts.dart';
import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/constants/sizes.dart';
import 'package:bandy_flutter/pages/authentication/sign_up/sign_up_email.dart';
import 'package:bandy_flutter/pages/authentication/widget/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SelectSignUp extends StatelessWidget {
  static const routeName = "/select-sign-up";

  const SelectSignUp({super.key});

  void _onEmailTap(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignUpEmail()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
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
                    const Text(
                      'Sign Up',
                      style: Fonts.titleLarge,
                    ),
                    Gaps.v20,
                    const Text(
                      'Lighting Up Your Korean Learning Journey',
                      style: Fonts.titleSmall,
                    ),
                    Gaps.v16,
                    // const AuthButton(
                    //   text: 'Continue with Apple',
                    //   icon: FaIcon(FontAwesomeIcons.apple),
                    // ),
                    // Gaps.v8,
                    // const AuthButton(
                    //   text: 'Continue with Google',
                    //   icon: FaIcon(FontAwesomeIcons.google),
                    // ),
                    // Gaps.v8,
                    // const AuthButton(
                    //   text: 'Continue with Facebook',
                    //   icon: FaIcon(FontAwesomeIcons.facebook),
                    // ),
                    // Gaps.v40,
                    GestureDetector(
                      onTap: () => _onEmailTap(context),
                      child: const AuthButton(
                        text: 'Use your email', // Or use your email
                        icon: FaIcon(FontAwesomeIcons.user),
                      ),
                    ),
                    Gaps.v20,
                    const Column(
                      children: [
                        Text(
                          'By signing up, you accept BANDY',
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

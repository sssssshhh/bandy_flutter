import 'package:bandy_flutter/constants/fonts.dart';
import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/constants/sizes.dart';
import 'package:bandy_flutter/pages/authentication/sign_in/sign_in_email.dart';
import 'package:bandy_flutter/pages/authentication/widget/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SelectSignIn extends StatelessWidget {
  const SelectSignIn({super.key});

  void _onSingInEmailTap(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignInEmail()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      'Sign In',
                      style: Fonts.titleLarge,
                    ),
                    const Text(
                      'Lighting Up Your Korean Learning Journey',
                      style: Fonts.titleSmall,
                    ),
                    Gaps.v8,
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
                      onTap: () => _onSingInEmailTap(context),
                      child: const AuthButton(
                        text: 'Use your email', // Or use your email
                        icon: FaIcon(FontAwesomeIcons.user),
                      ),
                    ),
                    Gaps.v8,
                    const Column(
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

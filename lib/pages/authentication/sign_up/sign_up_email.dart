import 'package:bandy_flutter/constants/fonts.dart';
import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/constants/sizes.dart';
import 'package:bandy_flutter/pages/authentication/widget/auth_button.dart';
import 'package:bandy_flutter/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpEmail extends StatefulWidget {
  const SignUpEmail({super.key});

  @override
  State<SignUpEmail> createState() => _SignUpEmailSignInState();
}

class _SignUpEmailSignInState extends State<SignUpEmail> {
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
                      'Sign Up',
                      style: Fonts.titleLarge,
                    ),
                    const Text(
                      'Lighting Up Your Korean Learning Journey',
                      style: Fonts.titleSmall,
                    ),
                    Gaps.v8,
                    const AuthButton(
                      text: 'Continue with Apple',
                      icon: FaIcon(FontAwesomeIcons.apple),
                    ),
                    Gaps.v8,
                    const AuthButton(
                      text: 'Continue with Google',
                      icon: FaIcon(FontAwesomeIcons.google),
                    ),
                    Gaps.v8,
                    const AuthButton(
                      text: 'Continue with Facebook',
                      icon: FaIcon(FontAwesomeIcons.facebook),
                    ),
                    Gaps.v8,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Or use your email',
                          style: Fonts.titleSmall,
                        ),
                      ],
                    ),
                    const Text(
                      'Email',
                      style: Fonts.titleSmall,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'email',
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      cursorColor: Theme.of(context).primaryColor,
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
                    Button(
                      text: 'Continue',
                      bgColor: Theme.of(context).primaryColor,
                      textColor: Colors.white,
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

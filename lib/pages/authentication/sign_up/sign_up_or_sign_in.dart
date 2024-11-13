import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/constants/sizes.dart';
import 'package:bandy_flutter/pages/authentication/sign_in/select_sign_in.dart';
import 'package:bandy_flutter/pages/authentication/sign_up/select_sign_up.dart';
import 'package:bandy_flutter/widgets/button.dart';
import 'package:flutter/material.dart';

class SignUpOrSignIn extends StatefulWidget {
  static const routeName = "/sign-up-or-sign-in";

  const SignUpOrSignIn({super.key});

  @override
  State<SignUpOrSignIn> createState() => _SignUpOrSignInState();
}

class _SignUpOrSignInState extends State<SignUpOrSignIn> {
  void _onSelectSignUpTap(BuildContext context) {
    Navigator.pushNamed(context, SelectSignUp.routeName);
  }

  void _onSelectSignInTap(BuildContext context) {
    Navigator.pushNamed(context, SelectSignIn.routeName);
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
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: []),
              ),
              const Text(
                'Lighting Up Your Korean Learning Journey',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Sizes.size24,
                ),
              ),
              Gaps.v2,
              Column(
                children: [
                  GestureDetector(
                    onTap: () => _onSelectSignUpTap(context),
                    child: const Button(
                      text: 'Sign up for free',
                      bgColor: Colors.orange, // TODO: Colors.orange[200]
                      textColor: Colors.white,
                    ),
                  ),
                  Gaps.v4,
                  GestureDetector(
                    onTap: () => _onSelectSignInTap(context),
                    child: const Button(
                      text: 'Already Sign up? Log in',
                      bgColor: Colors.orange, // TODO: Colors.orange[200]
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

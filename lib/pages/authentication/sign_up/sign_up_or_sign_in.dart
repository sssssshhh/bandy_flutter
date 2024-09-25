import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/constants/sizes.dart';
import 'package:bandy_flutter/pages/authentication/sign_in/sign_in_auth.dart';
import 'package:bandy_flutter/pages/authentication/sign_up/select_auth_or_self.dart';
import 'package:bandy_flutter/widgets/button.dart';
import 'package:flutter/material.dart';

class SignUpOrSignIn extends StatefulWidget {
  static String routeName = "signupsignin";
  static String routeURL = "/signupsignin";
  const SignUpOrSignIn({super.key});

  @override
  State<SignUpOrSignIn> createState() => _SignUpOrSignInState();
}

class _SignUpOrSignInState extends State<SignUpOrSignIn> {
  void _onSelectSignUpTap(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SelectSignUp()));
  }

  void _onSelectSignInTap(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SelectSignIn()));
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
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: []),
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

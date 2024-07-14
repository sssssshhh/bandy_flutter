import 'package:bandy_flutter/constants/fonts.dart';
import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/constants/sizes.dart';
import 'package:bandy_flutter/widgets/button.dart';
import 'package:flutter/material.dart';

class SignUpOrSignIn extends StatefulWidget {
  const SignUpOrSignIn({super.key});

  @override
  State<SignUpOrSignIn> createState() => _SignUpOrSignInSignInState();
}

class _SignUpOrSignInSignInState extends State<SignUpOrSignIn> {
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
              const SizedBox(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: []),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 200,
                    horizontal: 140,
                  ),
                ),
              ),
              const Text(
                'Lighting Up Your Korean Learning Journey',
                style: Fonts.titleSmall,
              ),
              const SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Button(
                      bgColor: Colors.orange, // TODO: Colors.orange[200]
                      textColor: Colors.white,
                      text: 'Sing up for free',
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Button(
                      bgColor: Colors.orange, // TODO: Colors.orange[200]
                      textColor: Colors.white,
                      text: 'Sing up for free',
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

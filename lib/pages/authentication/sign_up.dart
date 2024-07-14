import 'package:bandy_flutter/constants/fonts.dart';
import 'package:bandy_flutter/constants/sizes.dart';
import 'package:bandy_flutter/pages/authentication/widget/auth_button.dart';
import 'package:bandy_flutter/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpSignInState();
}

class _SignUpSignInState extends State<SignUp> {
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
                      AuthButton(
                        text: 'Continue with Apple',
                        icon: FaIcon(FontAwesomeIcons.apple),
                      ),
                      AuthButton(
                        text: 'Continue with Google',
                        icon: FaIcon(FontAwesomeIcons.google),
                      ),
                      AuthButton(
                        text: 'Continue with Facebook',
                        icon: FaIcon(FontAwesomeIcons.facebook),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

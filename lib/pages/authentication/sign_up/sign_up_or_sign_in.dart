import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/constants/sizes.dart';
import 'package:bandy_flutter/pages/authentication/sign_in/sign_in_email.dart';
import 'package:bandy_flutter/pages/authentication/sign_up/select_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
    Navigator.pushNamed(context, SignInEmail.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size40,
          vertical: Sizes.size40,
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0x88F2BC40), Color(0x22FFFB9D), Colors.transparent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0, 0.25, 1.0],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // const SizedBox(
            //   child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: []),
            // ),
            SvgPicture.asset('assets/svg/logo.svg'),
            Gaps.v28,
            const Text(
              'Lighting Up Your Korean Learning Journey',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: Sizes.size16, color: Color(0xFF808080)),
            ),
            const SizedBox(height: 150),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () => _onSelectSignUpTap(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF2BC40),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 56),
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text('Sign up for free', style: TextStyle(fontSize: 16)),
                ),
                Gaps.v14,
                ElevatedButton(
                  onPressed: () => _onSelectSignInTap(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF0F0F0),
                    foregroundColor: const Color(0xFF808080),
                    minimumSize: const Size(double.infinity, 56),
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text.rich(
                    TextSpan(children: [
                      TextSpan(text: 'Already signed up? ', style: TextStyle(fontSize: 16)),
                      TextSpan(
                          text: 'Log in',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ]),
                  ),
                ),
              ],
            ),
            Gaps.v28,
          ],
        ),
      ),
    );
  }
}

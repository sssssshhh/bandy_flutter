import 'package:bandy_flutter/widgets/button.dart';
import 'package:flutter/material.dart';

class SignUpSignIn extends StatefulWidget {
  const SignUpSignIn({super.key});

  @override
  State<SignUpSignIn> createState() => _SignUpSignInState();
}

class _SignUpSignInState extends State<SignUpSignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
            Text(
              'Lighting Up Your Korean Learning Journey',
              style: TextStyle(
                color: Theme.of(context).textTheme.titleLarge?.color,
                fontSize: 13,
              ),
            ),
            const Button(
              bgColor: Colors.orange, // TODO: Colors.orange[200]
              textColor: Colors.white,
              text: 'Sing up for free',
            ),
            const SizedBox(
              height: 8,
            ),
            const Button(
              bgColor: Colors.grey, // TODO: Colors.orange[200]
              textColor: Colors.black,
              text: 'Already signed up? Log in',
            ),
          ],
        ),
      ),
    );
  }
}

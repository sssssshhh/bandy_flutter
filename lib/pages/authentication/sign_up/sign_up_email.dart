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
  final TextEditingController _emailController = TextEditingController();

  String _email = '';

  @override
  void initState() {
    super.initState();

    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Use Your Email',
                      style: Fonts.titleLarge,
                    ),
                    Gaps.v8,
                    const Text(
                      'Email',
                      style: Fonts.titleSmall,
                    ),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Enter your Email Address',
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Button(
          text: 'Continue',
          bgColor: _email.isEmpty
              ? Colors.grey.shade300
              : Theme.of(context).primaryColor,
          textColor: Colors.white,
        ),
      ),
    );
  }
}

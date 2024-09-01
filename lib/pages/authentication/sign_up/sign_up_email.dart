import 'package:bandy_flutter/constants/fonts.dart';
import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/constants/sizes.dart';
import 'package:bandy_flutter/pages/authentication/sign_up/create_password.dart';
import 'package:bandy_flutter/pages/authentication/view_model/signup_view_model.dart';
import 'package:bandy_flutter/pages/authentication/widget/form_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpEmail extends ConsumerStatefulWidget {
  const SignUpEmail({super.key});

  @override
  ConsumerState<SignUpEmail> createState() => _SignUpEmailSignInState();
}

class _SignUpEmailSignInState extends ConsumerState<SignUpEmail> {
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
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String? _isEmailValid() {
    if (_email.isEmpty) return null;
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(_email)) {
      return "Email not valid";
    }
    return null;
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    if (_email.isEmpty || _isEmailValid() != null) return;
    ref.read(signUpForm.notifier).state = {"email": _email};
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreatePassword(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _onScaffoldTap,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Sign up",
            ),
          ),
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
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          onEditingComplete: _onSubmit,
                          autocorrect: false,
                          decoration: InputDecoration(
                            hintText: 'Enter your Email Address',
                            errorText: _isEmailValid(),
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
                        Gaps.v28,
                        GestureDetector(
                          onTap: _onSubmit,
                          child: FormButton(
                            text: 'Continue',
                            disabled: _email.isEmpty || _isEmailValid() != null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

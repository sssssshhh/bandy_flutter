import 'package:bandy_flutter/constants/fonts.dart';
import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/constants/sizes.dart';
import 'package:bandy_flutter/pages/authentication/sign_in/reset_password.dart';
import 'package:bandy_flutter/pages/authentication/view_model/login_view_model.dart';
import 'package:bandy_flutter/pages/lectures/main_navigation.dart';
import 'package:bandy_flutter/utils.dart';
import 'package:bandy_flutter/widgets/action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInEmail extends ConsumerStatefulWidget {
  static const routeName = "/sign-in-email";

  const SignInEmail({super.key});

  @override
  ConsumerState<SignInEmail> createState() => _SignInEmailState();
}

class _SignInEmailState extends ConsumerState<SignInEmail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final bool _obscureText = true;
  final _passwordFocusNode = FocusNode();

  Map<String, String> formData = {};

  void _onSubmitTap() async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        final result = await ref.read(loginProvider.notifier).login(
              formData["email"]!,
              formData["password"]!,
            );

        if (!mounted) return;

        if (result.hasError) {
          showFirebaseErrorSnack(context, result.error);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, MainNavigation.routeName, (route) => false);

          // 자동 로그인 설정
        }
      }
    }
  }

  void _onResetPasswordTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ResetPassword(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size40),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Sign In',
                      style: TextStyle(
                          fontSize: 32,
                          color: Color(0xFF1A1A1A),
                          fontWeight: FontWeight.bold)),
                  Gaps.v16,
                  const Text('Lighting Up Your Korean Learning Journey',
                      style: TextStyle(fontSize: 21, color: Color(0xFF808080))),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Gaps.v80,
                        TextFormField(
                          autofocus: true,
                          onFieldSubmitted: (value) =>
                              _passwordFocusNode.requestFocus(),
                          decoration: const InputDecoration(
                            hintText: 'Email address',
                            hintStyle: TextStyle(
                                fontSize: 16, color: Color(0xFFBEBEBE)),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFEAEAEA)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFF2BC40)),
                            ),
                          ),
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return "Please write your email";
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            if (newValue != null) {
                              formData['email'] = newValue;
                            }
                          },
                        ),
                        Gaps.v16,
                        TextFormField(
                          obscureText: _obscureText,
                          focusNode: _passwordFocusNode,
                          decoration: const InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(
                                fontSize: 16, color: Color(0xFFBEBEBE)),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFEAEAEA)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFF2BC40)),
                            ),
                          ),
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return "Plase write your password";
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            if (newValue != null) {
                              formData['password'] = newValue;
                            }
                          },
                        ),
                        Gaps.v40,
                        GestureDetector(
                          onTap: _onResetPasswordTap,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text.rich(TextSpan(children: [
                                TextSpan(
                                  text: 'Forgot your password? ',
                                  style: TextStyle(
                                      fontSize: 14, color: Color(0xFF808080)),
                                ),
                                TextSpan(
                                  text: 'Retrieve it here',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF3B3D49),
                                      fontWeight: FontWeight.bold),
                                ),
                              ])),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ActionButton(
                text: 'Sign in',
                onPressed: () => _onSubmitTap(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();

    super.dispose();
  }
}

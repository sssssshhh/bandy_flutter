import 'package:bandy_flutter/constants/sizes.dart';
import 'package:bandy_flutter/pages/authentication/view_model/signup_view_model.dart';
import 'package:bandy_flutter/pages/authentication/widget/form_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectLevel extends ConsumerStatefulWidget {
  const SelectLevel({super.key});

  @override
  ConsumerState<SelectLevel> createState() => _SelectLevelState();
}

class _SelectLevelState extends ConsumerState<SelectLevel> {
  void _onNextTap() {
    ref.read(signUpProvider.notifier).signUp(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Sign up",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size36,
          ),
          child: Column(children: [
            GestureDetector(
              onTap: _onNextTap,
              child: const FormButton(
                text: 'Continue',
                disabled: false,
              ),
            ),
          ]),
        ));
  }
}

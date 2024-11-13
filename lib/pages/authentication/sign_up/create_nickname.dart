import 'package:bandy_flutter/constants/fonts.dart';
import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/constants/sizes.dart';
import 'package:bandy_flutter/pages/authentication/sign_up/select_level.dart';
import 'package:bandy_flutter/pages/authentication/view_model/signup_view_model.dart';
import 'package:bandy_flutter/pages/authentication/widget/form_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateNickname extends ConsumerStatefulWidget {
  static const routeName = "/createNickname";

  const CreateNickname({super.key});

  @override
  ConsumerState<CreateNickname> createState() => _CreateNicknameState();
}

class _CreateNicknameState extends ConsumerState<CreateNickname> {
  final TextEditingController _nicknameController = TextEditingController();

  String _nickname = "";

  @override
  void initState() {
    super.initState();
    _nicknameController.addListener(() {
      setState(() {
        _nickname = _nicknameController.text;
      });
    });
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  String? _isNicknameValid() {
    // TODO: nickname 중복체크
    if (_nickname.isEmpty) return null;
    return null;
  }

  void _onNextTap() {
    if (_nickname.isEmpty || _isNicknameValid() != null) return;
    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {
      ...state,
      "nickname": _nickname,
    };

    Navigator.pushNamed(context, SelectLevel.routeName);
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v40,
            const Text(
              'Enter your nickname',
              style: Fonts.titleLarge,
            ),
            const Text(
              'Please enter the nickname you will use in the community.',
              style: Fonts.titleSmall,
            ),
            Gaps.v16,
            TextField(
              controller: _nicknameController,
              keyboardType: TextInputType.emailAddress,
              onEditingComplete: _onNextTap,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: 'Enter your nickname',
                errorText: _isNicknameValid(),
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
              onTap: _onNextTap,
              child: FormButton(
                text: 'Continue',
                disabled: _nickname.isEmpty || _isNicknameValid() != null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

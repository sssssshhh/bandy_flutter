import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/constants/sizes.dart';
import 'package:bandy_flutter/pages/authentication/view_model/signup_view_model.dart';
import 'package:bandy_flutter/pages/authentication/widget/form_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateNickname extends ConsumerStatefulWidget {
  const CreateNickname({super.key});

  @override
  ConsumerState<CreateNickname> createState() => _CreateNicknameState();
}

class _CreateNicknameState extends ConsumerState<CreateNickname> {
  final TextEditingController _nicknameController = TextEditingController();

  //  String _nickname = "";

  @override
  void initState() {
    super.initState();
    _nicknameController.addListener(() {
      setState(() {
        //_nickname = _nicknameController.text;
      });
    });
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v40,
            const Text(
              "Create Your nickname",
              style: TextStyle(
                fontSize: Sizes.size24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gaps.v16,
            TextField(
              enabled: false,
              controller: _nicknameController,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
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
                disabled: ref.watch(signUpProvider).isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

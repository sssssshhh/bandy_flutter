import 'package:bandy_flutter/constants/fonts.dart';
import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/constants/sizes.dart';
import 'package:bandy_flutter/pages/authentication/sign_up/create_password.dart';
import 'package:bandy_flutter/pages/authentication/widget/form_button.dart';
import 'package:flutter/material.dart';

class CreateNickname extends StatefulWidget {
  const CreateNickname({super.key});

  @override
  State<CreateNickname> createState() => _CreateNicknameSignInState();
}

class _CreateNicknameSignInState extends State<CreateNickname> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  String _nickname = '';

  void _onAccountTap(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const CreatePassword()));
  }

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

  String? _isnicknameValid() {
    if (_nickname.isEmpty) return "your nick name please";
    return null;
  }

  String? _isLastNameValid() {
    if (_nickname.isEmpty) return "your last name please";
    return null;
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _onScaffoldTap,
        child: Scaffold(
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
                          'Create Nickname',
                          style: Fonts.titleLarge,
                        ),
                        Gaps.v8,
                        const Text(
                          'Nickname',
                          style: Fonts.titleSmall,
                        ),
                        TextField(
                          controller: _nicknameController,
                          keyboardType: TextInputType.name,
                          autocorrect: false,
                          decoration: InputDecoration(
                            hintText: 'Enter your nickname',
                            errorText: _isnicknameValid(),
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
                          onTap: () => _onAccountTap(context),
                          child: FormButton(
                            text: 'Continue',
                            disabled: _nickname.isEmpty,
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

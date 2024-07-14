import 'package:bandy_flutter/constants/fonts.dart';
import 'package:bandy_flutter/constants/gaps.dart';
import 'package:bandy_flutter/constants/sizes.dart';
import 'package:bandy_flutter/pages/authentication/sign_up/create_password.dart';
import 'package:bandy_flutter/pages/authentication/widget/form_button.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountSignInState();
}

class _CreateAccountSignInState extends State<CreateAccount> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  String _firstName = '';

  void _onAccountTap(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const CreatePassword()));
  }

  @override
  void initState() {
    super.initState();

    _firstNameController.addListener(() {
      setState(() {
        _firstName = _firstNameController.text;
      });
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    super.dispose();
  }

  String? _isFirstNameValid() {
    if (_firstName.isEmpty) return "your first name please";
    return null;
  }

  String? _isLastNameValid() {
    if (_firstName.isEmpty) return "your last name please";
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
                          'Create Account',
                          style: Fonts.titleLarge,
                        ),
                        Gaps.v8,
                        const Text(
                          'First Name',
                          style: Fonts.titleSmall,
                        ),
                        TextField(
                          controller: _firstNameController,
                          keyboardType: TextInputType.name,
                          autocorrect: false,
                          decoration: InputDecoration(
                            hintText: 'Enter your first name',
                            errorText: _isFirstNameValid(),
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
                        Gaps.v8,
                        const Text(
                          'Last Name',
                          style: Fonts.titleSmall,
                        ),
                        TextField(
                          controller: _lastNameController,
                          keyboardType: TextInputType.name,
                          autocorrect: false,
                          decoration: InputDecoration(
                            hintText: 'Enter your last name',
                            errorText: _isLastNameValid(),
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
                            disabled: _firstName.isEmpty,
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

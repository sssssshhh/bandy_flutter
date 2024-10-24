import 'dart:async';

import 'package:bandy_flutter/pages/authentication/repos/authentication_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<AsyncValue> signUp() async {
    state = const AsyncValue.loading();
    final form = ref.read(signUpForm);
    state = await AsyncValue.guard(
      () async => await _authRepo.signUp(
        form["email"],
        form["password"],
      ),
    );

    if (!state.hasError) {
      _db
          .collection("users")
          .doc(
            form["email"],
          )
          .set({
        "level": form["level"],
        "nickname": form["nickname"],
        "status": 0,
      }).onError((e, _) => debugPrint("Error writing document: $e"));
    }

    return state;
  }
}

final signUpForm = StateProvider((ref) => {});

final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);

import 'dart:async';

import 'package:bandy_flutter/pages/authentication/repos/authentication_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(authRepo);
  }

  Future<AsyncValue> login(
    String email,
    String password,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => await _repository.signIn(email, password),
    );

    return state;
  }
}

final loginProvider = AsyncNotifierProvider<LoginViewModel, void>(
  () => LoginViewModel(),
);

import 'package:bandy_flutter/pages/authentication/repos/authentication_repo.dart';
import 'package:bandy_flutter/pages/authentication/sign_up/create_nickname.dart';
import 'package:bandy_flutter/pages/authentication/sign_up/sign_up_or_sign_in.dart';
import 'package:bandy_flutter/pages/lectures/main_navigation.dart';
import 'package:bandy_flutter/pages/onBoarding/onBoarding.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider((ref) {
  final authStateCheck = ref.watch(authState);
  // final isLoggedIn = ref.read(authRepo).authStateChanges().;

  return GoRouter(
    initialLocation: Onboarding.routeURL,
    redirect: (context, state) {
      if (authStateCheck.isLoading) {
        return null;
      }

      if (state.matchedLocation == SignUpOrSignIn.routeURL) {
        return MainNavigation.routeURL;
      }

      if (state.matchedLocation == CreateNickname.routeURL) {
        return CreateNickname.routeURL;
      }

      // if (!isLoggedIn) {
      //   if (state.matchedLocation != SignUpOrSignIn.routeURL) {
      //     return SignUpOrSignIn.routeURL;
      //   }
      // } else {
      //   if (state.matchedLocation == SignUpOrSignIn.routeURL) {
      //     return MainNavigation.routeURL;
      //   }
      // }
      return null;
    },
    routes: [
      GoRoute(
        path: Onboarding.routeURL,
        name: Onboarding.routeName,
        builder: (context, state) => const Onboarding(),
      ),
      GoRoute(
        path: CreateNickname.routeURL,
        name: CreateNickname.routeName,
        builder: (context, state) => const CreateNickname(),
      ),
      GoRoute(
        path: SignUpOrSignIn.routeURL,
        name: SignUpOrSignIn.routeName,
        builder: (context, state) => const SignUpOrSignIn(),
      ),
      GoRoute(
        path: MainNavigation.routeURL,
        name: MainNavigation.routeName,
        builder: (context, state) => const MainNavigation(),
      ),
    ],
  );
});

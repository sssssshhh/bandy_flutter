import 'package:bandy_flutter/pages/authentication/repos/authentication_repo.dart';
import 'package:bandy_flutter/pages/authentication/sign_up/sign_up_or_sign_in.dart';
import 'package:bandy_flutter/pages/lectures/main_navigation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider((ref) {
  final authStateCheck = ref.watch(authState);
  return GoRouter(
      initialLocation: SignUpOrSignIn.routeURL,
      redirect: (context, state) {
        if (authStateCheck.isLoading) {
          return null; // 현재 페이지에 머무름
        }
        final isLoggedIn = ref.read(authRepo).isLoggedIn;
        if (!isLoggedIn) {
          if ((state.matchedLocation) != SignUpOrSignIn.routeURL) {
            return SignUpOrSignIn.routeURL;
          }
        }
        return null;
      },
      routes: [
        GoRoute(
            path: SignUpOrSignIn.routeURL,
            name: SignUpOrSignIn.routeName,
            builder: (context, state) => const SignUpOrSignIn()),
        GoRoute(
            path: MainNavigation.routeURL,
            name: MainNavigation.routeName,
            builder: (context, state) => const MainNavigation()),
      ]);
});

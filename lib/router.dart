import 'package:bandy_flutter/pages/authentication/repos/authentication_pos.dart';
import 'package:bandy_flutter/pages/authentication/sign_up/sign_up_or_sign_in.dart';
import 'package:bandy_flutter/pages/lectures/main_navigation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
      initialLocation: SignUpOrSignIn.routeURL,
      redirect: (context, state) {
        final isLoggedIn = ref.read(authRepo).isLoggedIn;
        print(isLoggedIn);
        print(state.matchedLocation);
        if (!isLoggedIn) {
          if ((state.matchedLocation) != SignUpOrSignIn.routeURL) {
            return SignUpOrSignIn.routeURL;
          }
        }
        return null;
      },
      // redirect: (context, state) {
      //   final isLoggedIn = ref.read(authRepo).isLoggedIn;
      //   if (!isLoggedIn) {
      //     return null;
      //   }
      //   return null;
      // },
      routes: [
        GoRoute(
            path: SignUpOrSignIn.routeURL,
            name: SignUpOrSignIn.routeName,
            builder: (context, state) => const SignUpOrSignIn())
      ]);
});

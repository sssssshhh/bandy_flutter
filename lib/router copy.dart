// import 'package:bandy_flutter/pages/authentication/repos/authentication_repo.dart';
// import 'package:bandy_flutter/pages/authentication/sign_up/sign_up_or_sign_in.dart';
// import 'package:bandy_flutter/pages/lectures/main_navigation.dart';
// import 'package:bandy_flutter/pages/onBoarding/onBoarding.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';

// final routerProvider = Provider((ref) {
//   bool isLoggedIn = false;
//   final authStateCheck = ref.watch(authState);
//   ref.read(authRepo).authStateChanges().listen((User? user) {
//     if (user == null) {
//       print('User is currently signed out!');
//       isLoggedIn = false;
//     } else {
//       print('User is signed in!');
//       isLoggedIn = true;
//     }
//     ref.state = isLoggedIn;
//   });

//   return GoRouter(
//     initialLocation: Onboarding.routeURL,
//     redirect: (context, state) {
//       if (authStateCheck.isLoading) {
//         print("isLoading");
//         return null;
//       }
//       print(state.matchedLocation);
//       print(isLoggedIn);
//       if (isLoggedIn) {
//         if (state.matchedLocation == SignUpOrSignIn.routeURL) {
//           return MainNavigation.routeURL;
//         }
//       } else {
//         if (state.matchedLocation != SignUpOrSignIn.routeURL) {
//           return SignUpOrSignIn.routeURL;
//         }
//       }
//       return null;
//     },
//     routes: [
//       GoRoute(
//         path: Onboarding.routeURL,
//         name: Onboarding.routeName,
//         builder: (context, state) => const Onboarding(),
//       ),
//       GoRoute(
//         path: SignUpOrSignIn.routeURL,
//         name: SignUpOrSignIn.routeName,
//         builder: (context, state) => const SignUpOrSignIn(),
//       ),
//       GoRoute(
//         path: MainNavigation.routeURL,
//         name: MainNavigation.routeName,
//         builder: (context, state) => const MainNavigation(),
//       ),
//     ],
//   );
// });

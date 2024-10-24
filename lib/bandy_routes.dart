import 'package:bandy_flutter/pages/authentication/sign_in/select_sign_in.dart';
import 'package:bandy_flutter/pages/authentication/sign_in/sign_in_email.dart';
import 'package:bandy_flutter/pages/authentication/sign_up/create_nickname.dart';
import 'package:bandy_flutter/pages/authentication/sign_up/create_password.dart';
import 'package:bandy_flutter/pages/authentication/sign_up/select_level.dart';
import 'package:bandy_flutter/pages/authentication/sign_up/select_sign_up.dart';
import 'package:bandy_flutter/pages/authentication/sign_up/sign_up_email.dart';
import 'package:bandy_flutter/pages/authentication/sign_up/sign_up_or_sign_in.dart';
import 'package:bandy_flutter/pages/lectures/main_navigation.dart';
import 'package:bandy_flutter/pages/on_boarding/on_boarding.dart';
import 'package:bandy_flutter/pages/unknown_screen.dart';
import 'package:flutter/material.dart';

class BandyRoutes {
  static final RouteObserver<ModalRoute<void>> pageRouteObserver =
      RouteObserver<ModalRoute<void>>();
  static RouteFactory? get onGenerateRoute => (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return getScreen(settings.name, arguments: settings.arguments);
          },
        );
      };

  static RouteFactory? get onUnknownRoute =>
      (settings) => MaterialPageRoute(builder: (_) => const UnknownScreen());

  static Widget getScreen(String? name, {Object? arguments}) {
    return _getScreen(name, arguments: arguments) ?? const UnknownScreen();
  }

  static Widget? _getScreen(String? name, {Object? arguments}) {
    switch (name) {
      case Onboarding.routeURL:
        return _getOnBoarding();

      case SignUpOrSignIn.routeURL:
        return _getSignUpOrSignIn();

      case SelectSignUp.routeURL:
        return _getSelectSignUp();

      case SignUpEmail.routeURL:
        return _getSignUpEmail();

      case CreatePassword.routeURL:
        return _getCreatePassword();

      case CreateNickname.routeURL:
        return _getCreateNickname();

      case SelectLevel.routeURL:
        return _getSelectLevel();

      case SelectSignIn.routeURL:
        return _getSelectSignIn();

      case SignInEmail.routeURL:
        return _getSignInEmail();

      case MainNavigation.routeURL:
        return _getMainNavigation();

      default:
        return null;
    }
  }

  static Widget? _getOnBoarding() {
    return const Onboarding();
  }

  static Widget? _getSignUpOrSignIn() {
    return const SignUpOrSignIn();
  }

  static Widget? _getSelectSignUp() {
    return const SelectSignUp();
  }

  static Widget? _getSignUpEmail() {
    return const SignUpEmail();
  }

  static Widget? _getCreatePassword() {
    return const CreatePassword();
  }

  static Widget? _getCreateNickname() {
    return const CreateNickname();
  }

  static Widget? _getSelectLevel() {
    return const SelectLevel();
  }

  static Widget? _getSelectSignIn() {
    return const SelectSignIn();
  }

  static Widget? _getSignInEmail() {
    return const SignInEmail();
  }

  static Widget? _getMainNavigation() {
    return const MainNavigation();
  }
}

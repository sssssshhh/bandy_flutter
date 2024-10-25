import 'package:flutter/material.dart';

class RouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint("didPush: previous: ${previousRoute?.settings.name}, new: ${route.settings.name}");
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint("didPop: previous: ${previousRoute?.settings.name}, new: ${route.settings.name}");
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint("didRemove: previous: ${previousRoute?.settings.name}, new: ${route.settings.name}");
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    debugPrint("DidReplace: previous: ${oldRoute?.settings.name}, new: ${newRoute?.settings.name}");
  }
}

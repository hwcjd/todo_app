import 'package:flutter/material.dart';

class GoRouterObserver extends NavigatorObserver {
  GoRouterObserver();

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint(
      'Pushed route: ${route.settings.name} (previous: ${previousRoute?.settings.name})',
    );
    // Handle the push event
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('Popped route: ${route.settings.name}');
    // Handle the pop event
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint(
      'Removed route: ${route.settings.name} (previous: ${previousRoute?.settings.name})',
    );
    // Handle the remove event
  }

  @override
  void didChangeTop(Route topRoute, Route? previousTopRoute) {
    debugPrint(
      'Top route changed: ${topRoute.settings.name} (previous: ${previousTopRoute?.settings.name})',
    );
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    debugPrint(
      'didReplace: ${newRoute?.settings.name} (oldRoute: ${oldRoute?.settings.name})',
    );
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    debugPrint(
      'didStartUserGesture: ${route.settings.name} (previous: ${previousRoute?.settings.name})',
    );
  }

  @override
  void didStopUserGesture() {
    debugPrint('didStopUserGesture stopped');
  }


}

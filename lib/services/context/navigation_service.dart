import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigationKey;

  NavigationService(this.navigationKey);

  Future<Widget?> push(Widget route) async {
    return navigationKey.currentState
        ?.push(MaterialPageRoute(builder: (context) => route));
  }

  Future<Widget?> pushReplacement(Widget route) async {
    return navigationKey.currentState
        ?.pushReplacement(MaterialPageRoute(builder: (context) => route));
  }

  void pop() {
    return navigationKey.currentState?.pop();
  }
}

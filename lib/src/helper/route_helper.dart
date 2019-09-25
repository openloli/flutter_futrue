import 'dart:async';
import 'package:flutter/material.dart';

/// route to page
class RouteHelper {
  ///Open a new Widget
  static Future<T> pushWidget<T>(
    BuildContext context,
    Widget widget, {
    bool replaceRoot = false,
    bool replaceCurrent = false,
  }) {
    return pushRoute(
      context,
      MaterialPageRoute(builder: (ctx) => widget),
      replaceRoot: replaceRoot,
      replaceCurrent: replaceCurrent,
    );
  }

  ///Open a new Widget(page)
  static Future<T> pushRoute<T>(
    BuildContext context,
    PageRoute<T> route, {
    bool replaceRoot = false,
    bool replaceCurrent = false,
  }) {
    assert(!(replaceRoot == true && replaceCurrent == true));
    if (replaceRoot == true) {
      return Navigator.pushAndRemoveUntil(
        context,
        route,
        _rootRoute,
      );
    }
    if (replaceCurrent == true) {
      return Navigator.pushReplacement(context, route);
    }
    return Navigator.push(context, route);
  }

  ///Same as native startActivityForResult(), can carry data when returning after opening a new Widget(page)
  static Future<T> pushResultWidget<T>(
      BuildContext context, Widget widget) async {
    return await Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return widget;
    }));
  }
}

var _rootRoute = ModalRoute.withName("home");

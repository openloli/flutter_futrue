import 'package:flutter/material.dart';

///Some public Widget
class WidgetHelper {
  ///Add text Widget in AppBar(Have onPressed callback)
  static Widget appBarMenuText(
      {title, right = 6.0, width = 60.0, Function onPressed}) {
    return GestureDetector(
        onTap: () {
          onPressed();
        },
        child: Container(
          width: width,
          margin: EdgeInsets.only(right: right),
          child: Center(
            child: Text(title),
          ),
        ));
  }
}

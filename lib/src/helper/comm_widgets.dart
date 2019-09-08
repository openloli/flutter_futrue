import 'package:flutter/material.dart';

appBarMenuText({title, right = 6.0, Function onPressed}) {
  return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        margin: EdgeInsets.only(right: right),
        child: Center(
          child: Text(title),
        ),
      ));
}

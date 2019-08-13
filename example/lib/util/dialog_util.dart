import 'dart:async';
import 'package:flutter/material.dart';


class CommonUtils {
  static Future<Null> showLoadingDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new Material(
              color: Colors.transparent,
              child: WillPopScope(
                onWillPop: () => new Future.value(false),
                child: Center(
                  child: new Container(
                    width: 200.0,
                    height: 200.0,
                    padding: new EdgeInsets.all(4.0),
                    decoration: new BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/images/xiaoxin.gif",
                          fit: BoxFit.fill,
                        ),
                        Text(''),
                        new Container(child: new Text('努力加载中···')),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }
}


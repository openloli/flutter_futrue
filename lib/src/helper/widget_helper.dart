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

  /// def loading
  static Future<Null> showLoadingDialog(
    BuildContext context, {
    lodingTitle = '努力加载中···',
    width = 200.0,
    height = 200.0,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new Material(
              color: Colors.transparent,
              child: WillPopScope(
                onWillPop: () => new Future.value(false),
                child: Center(
                  child: new Container(
                    width: width,
                    height: height,
                    padding: new EdgeInsets.all(4.0),
                    decoration: new BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(''),
                        new Container(child: new Text(lodingTitle)),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }
}

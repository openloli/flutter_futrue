import 'package:flutter/material.dart';

///default dialog
class DialogHelper {
  static void defaultDialog(context,
      {title,
      cancel = true,
      cancelTitle = '取消',
      okTitle = '确定',
      Function callback}) async {
    showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text('$title'),
              ],
            ),
          ),
          actions: <Widget>[
            cancel
                ? FlatButton(
                    child: new Text('$cancelTitle'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                : Container(
                    height: 0.0,
                  ),
            FlatButton(
              child: new Text('$okTitle'),
              onPressed: () {
                callback();
              },
            ),
          ],
        );
      },
    );
  }
}

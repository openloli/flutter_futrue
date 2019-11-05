import 'package:flutter/material.dart';

///Some public Widget
class WidgetHelper {
  static Widget commSearchWidget(
    BuildContext context,
    TextEditingController editingController, {
    hintText = '请输入关键字',
    cancelTitle = '取消',
    cancelTitleStyle,
    hintStyleStyle,
    inputStyleStyle,
    fillColor,
    backgroundColor = Colors.blue,
    frameWidth = 330.0,
    inputWidth = 330.0 - 55.0,
    Function cleanCallback,
    Function cancelCallback,
    Function submitCallback,
  }) {
    return Container(
      height: 60.0,
      color: backgroundColor,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 12.0, right: 5.0),
            padding: EdgeInsets.only(left: 10.0),
            height: 30.0,
            width: frameWidth,
            decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
                borderRadius: BorderRadius.all(const Radius.circular(6.0))),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.search,
                  size: 22.0,
                  color: Colors.black54,
                ),
                Container(
                  child: Container(
                    padding: new EdgeInsets.only(left: 10.0),
                    child: Center(
                      child: Form(
                        autovalidate: true,
                        child: TextFormField(
                            textInputAction: TextInputAction.search,
                            controller: editingController,
                            style: inputStyleStyle ??
                                TextStyle(color: Colors.teal),
                            textAlign: TextAlign.start,
                            decoration: InputDecoration.collapsed(
                              fillColor:
                                  fillColor ?? Theme.of(context).primaryColor,
                              hintText: hintText,
                              hintStyle: hintStyleStyle ??
                                  TextStyle(color: Colors.black45),
                              filled: false,
                            ),
                            onFieldSubmitted: (value) {
                              submitCallback(value);
                            }),
                      ),
                    ),
                  ),
                  width: inputWidth,
                  height: 35.0,
                ),
                GestureDetector(
                  child: Icon(
                    Icons.cancel,
                    size: 20.0,
                    color: Colors.black54,
                  ),
                  onTap: () {
                    editingController.clear();
                    cleanCallback();
                  },
                ),
              ],
            ),
          ),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(left: 6.0),
              child: Text(
                cancelTitle,
                style: cancelTitleStyle ??
                    TextStyle(fontSize: 14.0, color: Colors.white),
              ),
            ),
            onTap: () {
              cancelCallback();
            },
          ),
        ],
      ),
    );
  }

  ///Add text Widget in AppBar(Have onPressed callback)
  static Widget appBarMenuText(
      {title, textStyle, right = 6.0, width = 60.0, Function onPressed}) {
    return GestureDetector(
        onTap: () {
          onPressed();
        },
        child: Container(
          width: width,
          margin: EdgeInsets.only(right: right),
          child: Center(
            child: Text(
              title,
              style: textStyle,
            ),
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

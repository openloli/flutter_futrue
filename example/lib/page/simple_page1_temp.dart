import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

///
class SimplePage1Temp extends StatefulWidget {
  @override
  _SimplePage1TempState createState() => _SimplePage1TempState();
}

class _SimplePage1TempState extends State<SimplePage1Temp>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //用户注册
          title: Text('2222'),
          actions: <Widget>[],
        ),
        body: GestureDetector(
          onTap: () {
            Navigator.of(context).pop('我是返回值');
          },
          child: Center(
            child: Container(
              width: 200.0,
              height: 120.0,
              child: Text('点我退出该页面并携带数据'),
            ),
          ),
        ));
  }
}

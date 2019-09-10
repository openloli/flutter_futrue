import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_futrue/flutter_futrue.dart';
import 'package:flutter_futrue_example/my/my_pro/my_proqress_view2.dart';

abstract class LHBaseState<T extends StatefulWidget> extends BaseState<T> {
  initProgressWidget() {
    return YourProgress2Widget();
  }

  initErrorWidget() {
    return Container(
      alignment: Alignment.center,
      width: 200.0,
      height: 120.0,
      color: Colors.blue[300],
      child: Text('自定义的错误页面：$errorMsg'),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_futrue/flutter_futrue.dart';
import 'package:flutter_futrue/src/bean/comm_bean.dart';
import 'package:flutter_futrue_example/util/dialog_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_futrue/src/base/base_view.dart';

abstract class BaseStateForCustomDialog2<T extends StatefulWidget> extends BaseState<T>
    implements IBaseView {

  @override
  void showLoading() {
    try {
      if (!isLoading) {
        isLoading = true;
        CommonUtils.showLoadingDialog(context);
      }
    } catch (e) {
      print('catch $e');
    }
  }


}
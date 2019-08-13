import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_futrue/flutter_futrue.dart';
import 'package:flutter_futrue/src/bean/comm_bean.dart';
import 'package:flutter_futrue_example/util/dialog_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_futrue/src/base/base_view.dart';

abstract class BaseStateForCustomDialog<T extends StatefulWidget> extends BaseState<T>
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


  List<String> items = [];
  Future<dynamic> refresh() async {
    print('refresh 11111 = ');
    items.clear();
    state = DataState.normal;
    refreshController.loadComplete();
    hideLoading();
    await onRefresh().then((result) {
      print('【0、1：normal】【2、4：noData】【3、5：noNetwork】');
      print('refresh result = $result');
      if (result == 0) {
        items = ["10条的", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
        refreshController.refreshCompleted();
        useNetData(items);
      } else if (result == 1) {
        items = ["5条的", "25", "53", "54", "55"];
        refreshController.refreshCompleted();
      } else if (result == 2 || result == 4) {
        refreshController.refreshFailed();
        state = DataState.noData;
        useNetData(items);
      } else if (result == 3 || result == 5) {
        refreshController.refreshFailed();
        state = DataState.noNetwork;
      }
      if (items.length >= 10) {
        isLoadMore = true;
      } else {
        isLoadMore = false;
      }

      print('state = $state');
      setState(() {});
    });
  }

  Future<dynamic> loading() async {
    Future.delayed(const Duration(milliseconds: 2000)).then((val) {
      List<String> temp = [];
      onLoading().then((result) {
        refreshController.loadComplete();
        print('loading result = $result');
        if (result == 0) {
          temp = [
            "加载更多，新增10条",
            "第二条",
            "加载",
            "加载",
            "加载",
            "加载",
            "加载",
            "加载",
            "加载",
            "加载"
          ];
        } else if (result == 1) {
          temp = [
            "加载更多，新增2条", "第二条",
          ];
        } else if (result == 2 || result == 4 || result == 5) {
          refreshController.loadNoData();
        } else if (result == 3) {
          refreshController.loadFailed();
        }
        items.addAll(temp);
        setState(() {});
      });
    });
  }
}
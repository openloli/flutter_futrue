import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_futrue/flutter_futrue.dart';
import 'package:flutter_futrue_example/base/basestate_custom_dialog2.dart';
import 'package:flutter_futrue_example/dao/bean/simple_bean.dart';
import 'package:flutter_futrue_example/dao/simple_dao.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SimplePage2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SimplePage2State();
  }
}

class _SimplePage2State extends BaseStateForCustomDialog2<SimplePage2> {

  List<SimpleDataBean> modelList = [];
  int page = 1;

  /// 当前页面的标题，不写该方便表示无 AppBar
  @override
  String appBarTitle() {
    return '真数据示范';
  }

  /// AppBar 一个或多个右上角按钮，不写该方法表示无右上角按钮
  @override
  List<Widget> buildAppBarActions() {
    return [IconButton(icon: Icon(Icons.refresh), onPressed: () {
      showLoading();
      Future.delayed(const Duration(milliseconds: 1000)).then((val) {
        refresh();
      });
    },)
    ];
  }

  /// 正文内容，即 body:buildBody()
  @override
  buildBody() {
    return ListView.builder(
      itemBuilder: (c, i) =>
          Card(child: Center(child: Text(modelList[i].name))),
      itemExtent: 100.0,
      itemCount: modelList.length,
    );
  }

  /// 刷新方法
  @override
  Future<dynamic> onRefresh() {
    print('，，，onRefresh');
    page = 1;
    return SimpleDao.getData10();
  }

  /// 加载更多
  @override
  Future<dynamic> onLoading() {
    print('，，，onLoading');
    page++;
    return SimpleDao.getData4();
  }

  /// 具体页面的数据处理
  /// 在该页面，通过 onRefresh 去触发数据获取，除了正常情况意外，都不需要在单独处理
  /// 数据正常时，父类方法返回的是 Object data ，但是具体页面具体接口我们是知道的
  /// 所以内部数据是list,还是Object 我们是知道的，所以，针对处理即可
  @override
  void useNetData(Object data) {
    if (page == 1) {
      modelList.clear();
    }
    List<dynamic> temp = data;
    temp.forEach((v) {
      modelList.add(new SimpleDataBean.fromJson(v));
    });
    setState(() {});
  }
}



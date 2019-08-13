import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_futrue/flutter_futrue.dart';
import 'package:flutter_futrue_example/base/basestate_custom_error.dart';
import 'package:flutter_futrue_example/dao/simple_dao.dart';
import 'package:flutter_futrue_example/base/basestate_custom_dialog.dart';

class SimplePage4 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SimplePage4State();
  }
}

class _SimplePage4State extends BaseStateForCustomError<SimplePage4>
{
  @override
  String appBarTitle() {
    return '假数据，右上角随机获取数据';
  }


  @override
  List<Widget> buildAppBarActions() {
    return [IconButton(icon: Icon(Icons.refresh), onPressed: () {
      print('buildAppBarActions onclick');
      showLoading();
      Future.delayed(const Duration(milliseconds: 1000)).then((val) {
        refresh();
      });
    },)
    ];
  }

  @override
  buildBody() {
    return ListView.builder(
      itemBuilder: (c, i) => Card(child: Center(child: Text(items[i]))),
      itemExtent: 100.0,
      itemCount: items.length,
    );
  }

  @override
  Future<dynamic> onRefresh() {
    print('，，，onRefresh');
    return SimpleDao.login();
  }

  @override
  Future<dynamic> onLoading() {
    return SimpleDao.login6();
  }


  @override
  void useNetData(Object data) {
    print('SimplePage1 useNetData $data');
  }
}



import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_futrue/flutter_futrue.dart';
import 'package:flutter_futrue_example/dao/simple_dao.dart';
import 'package:flutter_futrue_example/base/basestate_custom_dialog.dart';

class SimplePage3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SimplePage3State();
  }
}

class _SimplePage3State extends BaseStateForCustomDialog<SimplePage3> {

  @override
  String appBarTitle() {
    return '假数据，右上角触发转圈';
  }

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


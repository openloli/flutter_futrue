import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_futrue/flutter_futrue.dart';
import 'package:flutter_futrue_example/base/basestate_custom_error.dart';
import 'package:flutter_futrue_example/dao/simple_dao.dart';
import 'package:flutter_futrue_example/base/basestate_custom_dialog.dart';

class SimplePage5 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SimplePage5State();
  }
}

class _SimplePage5State extends BaseStateForCustomError<SimplePage5> {
  @override
  String appBarTitle() {
    return '有其他按钮触发网络的情况';
  }


  @override
  List<Widget> buildAppBarActions() {
    return [
      IconButton(icon: Icon(Icons.refresh), onPressed: () {
        showLoading();
        Future.delayed(const Duration(milliseconds: 1000)).then((val) {
          SimpleDao.getData4().then((rusult) {
            print('${rusult.toString()}');
            hideLoading();
          });
        });
      },),
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



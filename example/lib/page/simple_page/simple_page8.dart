import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_futrue_example/base/basestate_custom_data.dart';
import 'package:flutter_futrue_example/dao/simple_dao.dart';

class SimplePage8 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SimplePage8State();
  }
}

class _SimplePage8State extends BaseStateForCustomData<SimplePage8> {
  @override
  String appBarTitle() {
    return '列表中有输入框的情况';
  }

  @override
  buildBody() {
    return ListView.builder(
      itemExtent: 100.0,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            alignment: Alignment.center,
            height: 80.0,
            child: Column(
              children: <Widget>[
                Text('${items[index]}'),
                TextField(
                  decoration: InputDecoration(
                      labelText: "请输入内容",
                      filled: true,
                      fillColor: Colors.grey.shade50
                  ),
                ),
              ],
            )
        );
      },
    );
  }

  @override
  Future<dynamic> onRefresh() {
    print('，，，onRefresh');
    return SimpleDao.login();
  }

  @override
  void useNetData(Object data) {
    print('SimplePage1 useNetData $data');
  }


}



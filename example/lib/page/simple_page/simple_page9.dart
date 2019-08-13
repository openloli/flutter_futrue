import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_futrue_example/base/basestate_custom_data.dart';
import 'package:flutter_futrue_example/dao/simple_dao.dart';

class SimplePage9 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SimplePage9State();
  }
}

class _SimplePage9State extends BaseStateForCustomData<SimplePage9> {
  @override
  String appBarTitle() {
    return '九宫格';
  }

  @override
  buildBody() {
    return GridView.builder(
      padding: EdgeInsets.only(top: 2.0, left: 2.0, right: 2.0),
      itemCount: items.length,
      itemBuilder: (context, i) {
        String keyName = items[i];
        return new Material(
          elevation: 4.0,
          color: i % 2 == 0 ? Colors.blue.withOpacity(0.7) : Colors.green
              .withOpacity(0.7),
          borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
          child: new InkWell(
              onTap: () {
              },
              child:
              new Container(
                margin: EdgeInsets.all(5.0),
                alignment: Alignment.center,
                child: new Text(keyName,
                  style: TextStyle(color: Colors.white, fontSize: 16.0),),
              )
          ),
        );
      },
      gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
        maxCrossAxisExtent: 160.0,
      ),
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



import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_futrue/flutter_futrue.dart';
import 'package:flutter_futrue_example/dao/simple_dao.dart';
import 'package:flutter_futrue_example/dao/bean/simple_bean.dart';


class SimplePage10 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SimplePage10State();
  }
}

class _SimplePage10State extends BaseState<SimplePage10> {

  @override
  void initState() {
    super.initState();
  }


  @override
  String appBarTitle() {
    return '非列表页面(如我的页面)';
  }

  @override
  buildBody() {
    return
      SingleChildScrollView(
        child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 120.0,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 4,
                  color: Colors.green,
                  child: Image.network(model == null
                      ?
                  'http://wx2.sinaimg.cn/orj360/007ukfVdly1g5axxlste8j335q4qm4qr.jpg'
                      :
                  model.imageUrl),
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 60.0,
                  color: Colors.blue,
                  child: Text('我是昵称${model == null ? '' : model.petName}',
                    style: TextStyle(color: Colors.white),),
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 60.0,
                  color: Colors.yellow,
                  child: Text('我是${model == null ? '' : model.imageUrl}',
                    style: TextStyle(color: Colors.white),),
                ), Container(
                  alignment: Alignment.center,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 60.0,
                  color: Colors.orange,
                  child: Text('我是${model == null ? '' : model.name}',
                    style: TextStyle(color: Colors.white),),
                ), Container(
                  alignment: Alignment.center,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 60.0,
                  color: Colors.black,
                  child: Text('我是${model == null ? '' : model.id}',
                    style: TextStyle(color: Colors.white),),
                ), Container(
                  alignment: Alignment.center,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 60.0,
                  color: Colors.cyan,
                  child: Text('我是${model == null ? '' : model.name}',
                    style: TextStyle(color: Colors.white),),
                ), Container(
                  alignment: Alignment.center,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 60.0,
                  color: Colors.purple,
                  child: Text('我是${model == null ? '' : model.id}',
                    style: TextStyle(color: Colors.white),),
                ),
              ],
            )
        ),
      );
  }

  @override
  Future<dynamic> onRefresh() {
    print('，，，onRefresh');
    return SimpleDao.getData4();
  }


  List<SimpleDataBean> modelList = [];
  SimpleDataBean model;

  @override
  void useNetData(Object data) {
    List<dynamic> temp = data;
    temp.forEach((v) {
      modelList.add(new SimpleDataBean.fromJson(v));
    });
    if (modelList.length > 0) {
      model = modelList[0];
    }
  }
}



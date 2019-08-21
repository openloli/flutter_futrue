import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_futrue/flutter_futrue.dart';
import 'package:flutter_futrue_example/base/basestate_no_refresh.dart';
import 'package:flutter_futrue_example/dao/simple_dao.dart';
import 'package:flutter_futrue_example/page/simple_page/simple_page12_other.dart';


class SimplePage12 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SimplePage12State();
  }
}

class _SimplePage12State extends BaseState<SimplePage12> {


  @override
  String appBarTitle() {
    return '从上个页面返回后刷新页面';
  }

  @override
  buildBody() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10.0),
          child: CupertinoButton(
            color: Colors.blue,
            pressedOpacity: 0.5,
            child: Text('点我跳转页面'),
            onPressed: () {
              content = '重置';
              setState(() {});
              callUI();
            },
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10.0),
          child: CupertinoButton(
            color: Colors.green,
            pressedOpacity: 0.5,
            child: Text('点我获取网络'),
            onPressed: () {
              content = '重置';
              setState(() {});
              showLoading();
              Future.delayed(const Duration(milliseconds: 1000)).then((val) {
                refresh();
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('$content', maxLines: 10,),
        ),

      ],
    );
  }


  @override
  Future<dynamic> onRefresh() {
    print('，，，onRefresh');
    return SimpleDao.getData10();;
  }

  var content = '这里是网络数据显示的地方';

  @override
  void useNetData(Object data) {
    print('useNetData 执行了吗$data');
    content = data.toString();
    setState(() {});
  }

  void callUI() async {
    String result = await Navigator.push(context, new MaterialPageRoute(
        builder: (BuildContext context) {
          return new SimplePage12Other();
        }));
    if (result != null) {
      print('callUI result$result');
      if (result.contains('给我刷新数据')) {
        showLoading();
        Future.delayed(const Duration(milliseconds: 1000)).then((val) {
          refresh();
        });
      } else {
        content = result;
        setState(() {});
      }
    }
  }
}



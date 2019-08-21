import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_futrue/flutter_futrue.dart';
import 'package:flutter_futrue_example/base/basestate_no_refresh.dart';
import 'package:flutter_futrue_example/dao/simple_dao.dart';
import 'package:flutter_futrue_example/dao/bean/simple_bean.dart';


class SimplePage12Other extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SimplePage12OtherState();
  }
}

class _SimplePage12OtherState extends BaseStateForNoRefresh<SimplePage12Other> {


  @override
  String appBarTitle() {
    return '展示回退效果';
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
            child: Text('返回文字'),
            onPressed: () {
              Navigator.of(context).pop('我是上个页面传递来的数据，哈哈哈哈');
            },
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10.0),
          child: CupertinoButton(
            color: Colors.green,
            pressedOpacity: 0.5,
            child: Text('让上个页面刷新数据'),
            onPressed: () {
              Navigator.of(context).pop('给我刷新数据！');
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('$content2'),
        ),
      ],
    );
  }


  @override
  Future<dynamic> onRefresh() {
    print('，，，onRefresh');
    return SimpleDao.getData10();;
  }

  var content2 = '这里是网络数据显示的地方';

  @override
  void useNetData(Object data) {
    print('useNetData 执行了吗$data');
    content2 = data.toString();
    setState(() {});
  }
}



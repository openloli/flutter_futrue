import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_futrue_example/base/basestate_custom_data.dart';
import 'package:flutter_futrue_example/dao/simple_dao.dart';

class SimplePage7 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SimplePage7State();
  }
}

class _SimplePage7State extends BaseStateForCustomData<SimplePage7> {
  @override
  String appBarTitle() {
    return '底部部布局2';
  }

  @override
  List<Widget> buildAppBarActions() {
    return [
      IconButton(icon: Icon(Icons.refresh), onPressed: () {
        showLoading();
        Future.delayed(const Duration(milliseconds: 1000)).then((val) {
          refresh();
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
  buildFloatingActionButton() {
    return Row(
      children: <Widget>[
        Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(left: 5.0, right: 2.0, bottom: 2.0),
              child: CupertinoButton(
                color: Colors.blue,
                child: Text('hello'),
                onPressed: () {
                  print('hello ...');

                  showDialog(
                      context: context,
                      builder: (_) => _generateAlertDialog2());
                },
              ),)
        ),
        Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(left: 2.0, right: 5.0, bottom: 2.0),
              child: CupertinoButton(
                color: Colors.blue,
                child: Text('word'),
                onPressed: () {
                  print('hello ...');
                  showDialog(
                      context: context, builder: (_) => _generateAlertDialog());
                },
              ),)
        ),
      ],
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

  _generateSimpleDialog() {
    return SimpleDialog(
      title: Text('simple dialog title'),
      children: <Widget>[
        Container(
          height: 100,
          child: Text('这里填写内容'),
        ),
        FlatButton(
          child: Text('取消'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('确认'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  _generateAlertDialog() {
    return AlertDialog(
      title: Text('这是标题'),
      content: Text('这是内容'),
      actions: <Widget>[
        FlatButton(
          child: Text('取消'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('确认'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  _generateAlertDialog2() {
    return CupertinoAlertDialog(
      title: Text('Tambah baru'),
      content: Card(
        color: Colors.transparent,
        elevation: 0.0,
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  labelText: "Nama",
                  filled: true,
                  fillColor: Colors.grey.shade50
              ),
            ),
          ],
        ),
      ),
    );
  }


}



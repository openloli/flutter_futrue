import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_futrue/flutter_futrue.dart';
import 'package:flutter_futrue_example/base/basestate_custom_data.dart';
import 'package:flutter_futrue_example/base/basestate_custom_error.dart';
import 'package:flutter_futrue_example/dao/simple_dao.dart';
import 'package:flutter_futrue_example/base/basestate_custom_dialog.dart';

class SimplePage11 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SimplePage11State();
  }
}

class _SimplePage11State extends BaseStateForCustomData<SimplePage11> {
  @override
  void initState() {
    isLoadMore = false;
    super.initState();
  }

  @override
  String appBarTitle() {
    return '头布局情况';
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


  Widget buildBodyHead() {
    return GestureDetector(
      child: Center(
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height / 5,
          color: Colors.green,
          child: Text('我是头布局', style: TextStyle(color: Colors.white),),
        ),
      ),
      onTap: () {
        print('头布局 被点击了');
      },
    );
  }

  @override
  buildBody() {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return Column(
            children: <Widget>[
              buildBodyHead(),
              Container(
                alignment: Alignment.center,
                height: 80.0,
                color: Colors.purple,
                child: Text('${items[index]}'),
              )
            ],
          );
        } else {
          return Container(
            alignment: Alignment.center,
            height: 80.0,
            color: index % 2 == 0 ? Colors.blue : Colors.green,
            child: Text('${items[index]}'),
          );
        }
      },
    );
  }

  @override
  Widget buildBodyFoot() {
    return GestureDetector(
      child: Center(
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: 60.0,
          color: Colors.blue,
          child: Text('我是 尾巴', style: TextStyle(color: Colors.white),),
        ),
      ),
      onTap: () {
        print('尾巴 被点击了');
      },
    );
  }

  @override
  Future<dynamic> onRefresh() {
    print('，，，onRefresh');
    return SimpleDao.login();
  }

//  @override
//  Future<dynamic> onLoading() {
//    return SimpleDao.login6();
//  }


  @override
  void useNetData(Object data) {
    print('SimplePage1 useNetData $data');
  }
}



import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_futrue_example/dao/simple_dao.dart';
import 'package:flutter_futrue_example/base/basestate_custom_data.dart';

class SimplePage1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SimplePage1State();
  }
}

class _SimplePage1State extends BaseStateForCustomData<SimplePage1> {
  @override
  String appBarTitle() {
    return '假数据示范';
  }

  @override
  List<Widget> buildAppBarActions() {
    return [
      IconButton(
          icon: Icon(Icons.refresh), onPressed: () {
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
  Future<dynamic> onRefresh() {
    return SimpleDao.login();
  }

  @override
  Future<dynamic> onLoading() {
    return SimpleDao.login6();
  }

  @override
  void useNetData(Object data) {
    // 假数据用不到该方法
  }

}


//Align _buildLoginButton(BuildContext context) {
//  return Align(
//    child: SizedBox(
//      height: 45.0,
//      width: 270.0,
//      child: RaisedButton(
//        child: Text(
//          '登录',
//          style: Theme
//              .of(context)
//              .primaryTextTheme
//              .headline,
//        ),
//        color: Colors.black,
//        onPressed: () {
//          print('登录被触发了');
////            _login();
//          showLoading();
//          Future.delayed(const Duration(milliseconds: 3000)).then((val) {
//            hideLoading();
//          });
//        },
//        shape: StadiumBorder(side: BorderSide()),
//      ),
//    ),
//  );
//}
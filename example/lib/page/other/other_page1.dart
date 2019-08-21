import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_futrue/flutter_futrue.dart';
import 'package:flutter_futrue_example/page/other/update_app.dart';

class OtherPage1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _OtherPage1State();
  }
}

class _OtherPage1State extends BaseState<OtherPage1> {
  @override
  String appBarTitle() {
    return '假数据示范';
  }

  @override
  void init() {
    isRefresh = false;
    isLoadMore = false;
    super.init();
  }

  @override
  List<Widget> buildAppBarActions() {
    return [
      IconButton(
        icon: Icon(Icons.refresh), onPressed: () {
        Future.delayed(const Duration(milliseconds: 1000)).then((val) {
          _checkAndUpate();
        });
      },),
    ];
  }

  void _checkAndUpate() {
    // 可以在第一次打开APP时执行"版本更新"的网络请求
    UpdateApp _updateApp = new UpdateApp();
    // context 能拿到
    try {
      _updateApp.checkAndUpate(context);
    } catch (e) {
      print('catch$e');
    }
  }

  @override
  buildBody() {
    print('OtherPage1 build');
    return ListView.builder(
      itemBuilder: (c, i) => Card(child: Center(child: Text('111'))),
      itemExtent: 100.0,
      itemCount: 5,
    );
  }

//  @override
//  Future<dynamic> onRefresh() {
//    return SimpleDao.login();
//  }
//
//  @override
//  Future<dynamic> onLoading() {
//    return SimpleDao.login6();
//  }
//
//  @override
//  void useNetData(Object data) {
//    // 假数据用不到该方法
//  }

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
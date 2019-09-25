
import 'package:flutter/scheduler.dart';
import 'package:flutter_futrue_example/my/my_pro/my_proqress_view2.dart';
import 'package:flutter_futrue_example/net/bean/simple_bean.dart';
import 'package:flutter_futrue_example/net/net.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'dart:math';

///
class SimplePage1Temp extends StatefulWidget {
  @override
  _SimplePage1TempState createState() => _SimplePage1TempState();
}

class _SimplePage1TempState extends State<SimplePage1Temp>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //用户注册
          title: Text('2222'),
          actions: <Widget>[],
        ),
        body: GestureDetector(
          onTap: (){
            Navigator.of(context).pop('我是返回值');
          },
          child: Center(
            child: Container(
              width: 200.0,
              height: 120.0,
              child: Text('点我退出该页面并携带数据'),
            ),
          ),
        )
    );
  }
}

//刷新代码
//    var path = '';
//    var random = Random().nextInt(4);
//    print('onRefresh，random = ${random} (0模拟10条、1模拟3条、2模拟0条、3模拟登录失效)');
//    if (random == 0) {
//      path = API_date10;
//    } else if (random == 1) {
//      path = API_date3;
//    } else if (random == 2) {
//      path = API_date0;
//    } else if (random == 3) {
//      path = API_date900;
//    } //临时
//    refreshController.loadComplete();
//
//    Future.delayed(const Duration(milliseconds: 2000)).then((val) {
//      HttpManager()
//          .get(
//        who: 'path',
//        path: path,
//      )
//          .then((result) {
//        if (result != null) {
//          if (result.toString().length > 100) {
//            print('result = ${result.toString().substring(0, 100)}');
//          } else {
//            print('result = ${result.toString()}');
//          } //临时
//
//          first = false;
//          errorWidget = false;
//          modelList.clear();
//          CommBean bean = CommBean.fromJson(result);
//          if (bean.data == null || bean.data == '') {
//            refreshController.refreshFailed();
//          } else {
//            refreshController.refreshCompleted();
//            if (bean.code == normalCode) {
////            dataCallback(bean.data);--->
//              List<dynamic> temp = bean.data;
//              temp.length >= 10 ? isLoading = true : isLoading = false;
//              temp.forEach((v) {
//                modelList.add(new SimpleDataBean.fromJson(v));
//              });
//
//              setState(() {});
//            } else if (bean.code == noDataCode) {
//              errorMsg = bean.msg;
//              errorWidget = true;
//              setState(() {});
//            } else if (bean.code == tokenInvalidCode) {
//              callDialog(
//                  title: bean.msg,
//                  context: context,
//                  cancel: false,
//                  callback: () {
//                    print('这里是处理登出的逻辑，就退出当前页吧'); //临时
//                    Navigator.of(context).pop(); //临时
//                    Navigator.of(context).pop();
//                  });
//            } else {
//              errorMsg = bean.msg;
//              errorWidget = true;
//            }
//          }
//        } else {
//          first = false;
//          errorWidget = true;
////          widget.onRefreshCallback();
//          refreshController.refreshFailed();
//          checkConnectivity().then((onValue) {
//            errorMsg = onValue;
//            setState(() {});
//          });
//        }
//      });
//    });

//加载更多代码

//void onLoading() async {
//  var path = '';
//  var random = Random().nextInt(5);
//  print('onLoading，random = ${random} (0、4模拟10条、1模拟3条、2模拟0条、3模拟登录失效)');
//  if (random == 0 || random == 4) {
//    path = API_date10;
//  } else if (random == 1) {
//    path = API_date3;
//  } else if (random == 2) {
//    path = API_date0;
//  } else if (random == 3) {
//    path = API_date900;
//  } //临时
////    widget.onLoadingCallback();
//  page++;
//  Future.delayed(const Duration(milliseconds: 1000)).then((val) {
//    HttpManager()
//        .get(
//      who: path,
//      path: path,
//    )
//        .then((result) {
//      if (result != null) {
//        CommBean bean = CommBean.fromJson(result);
//        if (bean.data == null || bean.data == '') {
//          refreshController.loadFailed();
//        } else {
//          if (bean.code == normalCode) {
//            refreshController.loadComplete();
//            //            dataCallback(bean.data);--->
//            List<dynamic> temp = bean.data;
//            temp.length >= 10 ? isLoading = true : isLoading = false;
//            temp.forEach((v) {
//              modelList.add(new SimpleDataBean.fromJson(v));
//            });
//
//            setState(() {});
//          } else if (bean.code == noDataCode) {
//            refreshController.loadNoData();
//          } else if (bean.code == tokenInvalidCode) {
//            bean.msg = '模拟加载更多时，登录失效了'; //临时
//            callDialog(
//                title: bean.msg,
//                context: context,
//                cancel: false,
//                callback: () {
//                  print('这里是处理登出的逻辑，就退出当前页吧'); //临时
//                  Navigator.of(context).pop(); //临时
//                  Navigator.of(context).pop();
//                });
//          } else {
//            refreshController.loadFailed();
//          }
//        }
//      } else {
//        refreshController.loadFailed();
//      }
//    });
//  });
//}
//  bodyWidget() {
//    return Stack(
//      children: <Widget>[
//        SmartRefresher(
//          enablePullDown: true,
//          enablePullUp: isLoading,
//          header: WaterDropHeader(),
//          footer: CustomFooter(
//            builder: (BuildContext context, LoadStatus mode) {
//              Widget body;
//              if (mode == LoadStatus.idle) {
//                body = Text("");
//              } else if (mode == LoadStatus.loading) {
//                body = CupertinoActivityIndicator();
//              } else if (mode == LoadStatus.failed) {
//                body = Text("点击重试");
//              } else {
//                body = Text("没有更多数据了");
//              }
//              return Container(
//                height: 55.0,
//                child: Center(child: body),
//              );
//            },
//          ),
//          controller: refreshController,
//          onRefresh: onRefresh,
//          onLoading: onLoading,
//          child: errorWidget ? bodyError() : body(),
//        ),
//        //初始转圈扩展
//        new Offstage(
//          offstage: first ? false : true,
//          child: new Container(
//            alignment: Alignment.center,
//            color: Colors.white70,
//            child: YourProgress2Widget(),
//          ),
//        ),
//      ],
//    );
//  }
//
//  Widget bodyError() {
//    return Center(
//      child: GestureDetector(
//        child: Container(
//          alignment: Alignment.center,
//          width: 200.0,
//          height: 120.0,
//          color: Colors.green[300],
//          child: Text('$errorMsg'),
//        ),
//        onTap: () {
//          print('=============================');
//          modelList.clear();
//          SchedulerBinding.instance.addPostFrameCallback((_) {
//            refreshController.requestRefresh();
//          });
//        },
//      ),
//    );
//  }

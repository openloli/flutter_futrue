import 'package:flutter_futrue_example/net/api.dart';
import 'package:flutter_futrue_example/net/bean/simple_bean.dart';
import 'package:flutter_futrue_example/net/net.dart';
import 'package:flutter_futrue_example/page/simple_page1_temp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_futrue/flutter_futrue.dart';

///
class SimplePage12 extends StatefulWidget {
  @override
  _SimplePage12State createState() => _SimplePage12State();
}

class _SimplePage12State extends BaseState<SimplePage12>
    with SingleTickerProviderStateMixin {
  List<SimpleDataBean> modelList = [];
  bool isPrint = true;

  @override
  void initState() {
    onRefresh();
    super.initState();
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('1111111111'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.redeem),
              onPressed: () {
                callInitLoading();
                onRefresh();
              },
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                RouteHelper.pushResultWidget(context, new SimplePage1Temp())
                    .then((result) {
                  print('result = ${result.toString()}');
                  callInitLoading();
                  onRefresh();
                });
              },
            ),
          ],
        ),
        body: bodyWidget(
          modelList: modelList,
          onRefresh: onRefresh,
//          onLoading: onLoading,
          contentBody: body(),
        ));
  }

  void onRefresh() async {
    var path = Api.randomPath('onRefresh');
    callRefresh(
        modelList: modelList,
        dao: HttpManager().get(
          who: 'path',
          path: path,
        ),
        dataCallback: (Object bean) {
          List<dynamic> temp = bean;
//          temp.length >= 10 ? isLoading = true : isLoading = false;
          temp.forEach((v) {
            modelList.add(new SimpleDataBean.fromJson(v));
          });     setState(() {});
        },
        tokenInvalidCallback: () {
          print('这里是处理登出的逻辑，就退出当前页吧'); //临时
          Navigator.of(context).pop(); //临时
        });
  }

  void onLoading() async {
    var path = Api.randomPath('onLoading');
    callLoading(
        dao: HttpManager().get(
          who: path,
          path: path,
        ),
        dataCallback: (bean) {
          List<dynamic> temp = bean;
//          temp.length >= 10 ? isLoading = true : isLoading = false;
          callLoadingCheck(temp.length);
          temp.forEach((v) {
            modelList.add(new SimpleDataBean.fromJson(v));
          });     setState(() {});
        },
        tokenInvalidCallback: () {
          print('这里是处理登出的逻辑，就退出当前页吧'); //临时
          Navigator.of(context).pop(); //临时
        });
  }

  Widget body() {
    return ListView.builder(
      itemCount: modelList.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          alignment: Alignment.center,
          height: 80.0,
          child: Text('${modelList[index].name}'),
        );
      },
    );
  }
}

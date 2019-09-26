# flutter_future example 说明文档

首先说明的是，该插件不适合使用多方API的项目或DEMO(会定制很多BaseState)

1. 我的环境(mac+win10台式)

   ```dart
   Flutter: 1.7.8
   Java sdk: 8
   Android Studio: 3.4.2
   Android Tools: 3.4.2
   Gradle: gradle-5.1.1-all.zip
   ```

2. 我司接口格式

   ```dart
   待续
   ```

   

3. 待续

   ```dart
   
   
   ```

3.1 BaseStateForLocalData类

```
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_futrue/flutter_futrue.dart';
import 'package:flutter_futrue/src/base/base_view.dart';

abstract class BaseStateForLocalData<T extends StatefulWidget> extends BaseState<T>
    implements IBaseView {

  List<String> items = [];
  Future<dynamic> refresh() async {
    print('refresh 11111 = ');
    items.clear();
    state = DataState.normal;
    refreshController.loadComplete();
    hideLoading();
    await onRefresh().then((result) {
      print('【0、1：normal】【2、4：noData】【3、5：noNetwork】');
      print('refresh result = $result');
      if (result == 0|| result == 4) {
        items = ["10条的", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
        refreshController.refreshCompleted();
        useNetData(items);
      } else if (result == 1) {
        items = ["5条的", "25", "53", "54", "55"];
        refreshController.refreshCompleted();
      } else if (result == 2 ) {
        refreshController.refreshFailed();
        state = DataState.noData;
        useNetData(items);
      } else if (result == 3 || result == 5) {
        refreshController.refreshFailed();
        state = DataState.noNetwork;
      }
      if (items.length >= 10) {
        isLoadMore = true;
      } else {
        isLoadMore = false;
      }

      print('state = $state');
      print('isLoadMore = $isLoadMore');
      setState(() {});
    });
  }

  Future<dynamic> loading() async {
    Future.delayed(const Duration(milliseconds: 2000)).then((val) {
      List<String> temp = [];
      onLoading().then((result) {
        refreshController.loadComplete();
        print('loading result = $result');
        if (result == 0) {
          temp = [
            "加载更多，新增10条",
            "第二条",
            "加载",
            "加载",
            "加载",
            "加载",
            "加载",
            "加载",
            "加载",
            "加载"
          ];
        } else if (result == 1) {
          temp = [
            "加载更多，新增2条", "第二条",
          ];
        } else if (result == 2 || result == 4 || result == 5) {
          refreshController.loadNoData();
        } else if (result == 3) {
          refreshController.loadFailed();
        }
        items.addAll(temp);
        setState(() {});
      });
    });
  }
  Future<dynamic> onLoading() async {
  }
}
```

3.2具体页面的使用（这里就需要继承**BaseStateForLocalData**了）
```
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

class _SimplePage1State extends BaseStateForLocalData<SimplePage1> {
  @override
  String AppBarTitle() {
    return '假数据示范';
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
  Future<dynamic> onRefresh() {
    return SimpleDao.login();
  }

  @override
  Future<dynamic> onLoading() {
    return SimpleDao.login6();
  }

  @override
  void useNetData(Object data) {
    // 假数据没有用到该方法
  }
}
```
怎么样，朋友们，是不是很简单，快去使用吧！


4.**fqa**
4.1 你是用啥格式化json格式的？

[json_to_dart](https://javiercbk.github.io/json_to_dart/)

4.2 dao获取数据的类具体是咋写的？
```
  ///注意返回值 为Future<dynamic>
  static Future<dynamic> getData10({ page}) async {
    return HttpManager().get(
     ...
    );
  }
```
+
4.3 我要在AppBar设置右上角按钮咋整？
```
///在具体页面重载如下方法：（可以是多个按钮）
  @override
  List<Widget> buildAppBarActions() {
    return [
       //your code
    ];
  }
```
4.4 我要自定义转圈咋整？
```
abstract class YourClassName<T extends StatefulWidget> extends BaseState<T>
    implements IBaseView {
...
  @override
  void showLoading() {
    //your code
  }
...
```
4.5 我要自定义错误\无数据页面咋整？
```
abstract class YourClassName<T extends StatefulWidget> extends BaseState<T>
    implements IBaseView {
...
 buildBodyNoData() {
      //your code
  }

  buildBodyNoNetwork() {
    //your code
  }
...
```
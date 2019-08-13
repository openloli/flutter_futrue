>不知道您是否还记得，刚入手Flutter时候的惊艳。
>后来你是否为Json格式而苦恼，你是否已经习惯了各种括号...
>随着熟悉，不习惯的无限放大着，像极了爱情。
>**flutter_futrue** 让你的Flutter开发之旅回归本质:**极速构建漂亮的原生应用。**

在上一个项目开发的时候，产出了 [flutter_allroundrefresh 插件](https://www.jianshu.com/p/6148062cbb86) （**集下拉刷新、上拉加载、初始转圈、错误页面、异常重试、Token过期  的一条龙功能的插件**）极大的提高了团队的开发效率。

>经过一段时间沉淀后，发现这个小插件还是有很多不足的地方，比如**耦合度**的问题。
>尤其是**接口结果集格式**的高耦合问题，考虑到现在用flutter作为生产环境的公司（可能估计大概也许瞎猜的）~~还是相对较少~~
>不过最近看群里有小伙伴的公司都上线好几个Flutter的APP了，可喜可贺），~~估计更多的应该是移动开发者、前端、以及学生过来的（试水、学习）。~~
>~~这种情况就没有那么多正式接口，而大部分则是网络上的公共API，这样的API结果集格式花样百出，自然无法统一格式，这样的话该插件内部封装的高耦合数据解析方案反而成了她走向大众化插件的绊脚石。~~
>反正是要降低耦合的！

**那么如何降低这个耦合，又保留flutter_allroundrefresh上的功能呢？于是，~~苦思冥想，修炼了九九八十一天后~~便有了这篇文章中的新插件，flutter_futrue。（低耦合，更简洁，可定制接口解析方案。）**
>~~ps（好不容易修炼出来的金丹，居然被医院拿走了）~~

flutter_futrue 使用建造者模式的概念（把一个复杂的对象的构建与它的表示分离） ，即把公共的复杂的逻辑、功能、构建过程进行封装，使用一些方法进行具体表现（及可重载定制化）。
***
1.**这里需要先提一下MVC架构模式。**
笔者在架构之初，复习了一遍MVC、MVP、MVVM架构模式以及flutter上流行的状态管理BLoC、Redux，最后根据Flutter自身的特点，研究出了Flutter + MVC +Refresh的方案。
```
MVC架构模式在Flutter上继续保持着其优点：
耦合性低
重用性高
可维护性高

在Flutter上同样有MVC明显的缺点：
没有明确的定义
视图与控制器间的过于紧密的连接
```
MVC分别是Model（模型）、View（视图）、Controller（控制器）三个模块。
优点确实很明显，低耦合、重用、好维护、定制。
而缺点确实是划分不够明确：
>**Model（模型层）**则是对数据的储存和处理，再传递给视图层相应或者展示。
>在这里主要指Dao类，但这里仅仅是做数据的获取，不进行数据的处理。

>**View（视图层）**最主要完成前端的数据展示。
>在这里主要指当前page页面，或者说页面对应的buildBody（下的ListView、GridView）及其他buildXXX方法。

>**Controller（控制层）**是对数据的接收和触发事件的接收和传递。
>在这里主要指BaseState极其子类，Controller会对数据进行初步处理，用于处理数据的非正常情况的逻辑。
>具体的数据整理则交给了buildBodyNoData 该方法在 View层进行处理。


2.**使用**
2.1.添加依赖

```
dependencies:
  flutter_futrue: ^1.0.2
```
2.2.引入
```
import 'package:flutter_futrue/flutter_futrue.dart';
```

2.3.使用（完整的一个页面代码[注意 BaseState 关键点]）

```
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_futrue/flutter_futrue.dart';
import 'package:flutter_futrue_example/dao/simple_dao.dart';
import 'package:flutter_futrue_example/dao/bean/simple_bean.dart';

class SimplePage2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SimplePage2State();
  }
}

class _SimplePage2State extends BaseState<SimplePage2> {

  List<SimpleDataBean> modelList = [];
  int page = 1;

  /// 当前页面的标题，不写该方便表示无 AppBar
  @override
  String AppBarTitle() {
    return '真数据示范';
  }

  /// AppBar 一个或多个右上角按钮，不写该方法表示无右上角按钮
//  @override
//  List<Widget> buildAppBarActions() {}

  /// 正文内容，即 body:buildBody()
  @override
  buildBody() {
    return ListView.builder(
      itemBuilder: (c, i) =>
          Card(child: Center(child: Text(modelList[i].name))),
      itemExtent: 100.0,
      itemCount: modelList.length,
    );
  }

  /// 刷新方法
  @override
  Future<dynamic> onRefresh() {
    print('，，，onRefresh');
    page = 1;
    return SimpleDao.getData10();
  }

  /// 加载更多
  @override
  Future<dynamic> onLoading() {
    print('，，，onLoading');
    page++;
    return SimpleDao.getData4();
  }

  /// 具体页面的数据处理
  /// 在该页面，通过 onRefresh 去触发数据获取，除了正常情况意外，都不需要在单独处理
  /// 数据正常时，父类方法返回的是 Object data ，但是具体页面具体接口我们是知道的
  /// 所以内部数据是list,还是Object 我们是知道的，所以，针对处理即可
  @override
  void useNetData(Object data) {
    if (page == 1) {
      modelList.clear();
    }
    List<dynamic> temp = data;
    temp.forEach((v) {
      modelList.add(new SimpleDataBean.fromJson(v));
    });
    setState(() {});
  }
}

```
单从这个页面的代码来看，其实更像Android原生中的MVP模式，
通常情况下，或者说项目/DEMO使用的是标准接口，那么只需要使用该架构，每个页面继承 BaseState 即可，到这里就算入门了。

若项目/DEMO中的接口和笔者不一样，或者说嫌弃笔者审美下的转圈，错误页面，甚至是刷新头，那该怎么办？那就需要继续往下看了。

3.**进阶：可扩展BaseState**
>1.继承BaseState
>BaseStateForLocalData extends BaseState
>2.观察BaseState源码，选择需要自定义的方法/功能点
>如BaseStateForLocalData 则选择了需要处理本地数据
>实则重载了refresh()、loading(), 其他不做修改

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
4.1 我要在AppBar设置右上角按钮咋整？
```
///在具体页面重载如下方法：（可以是多个按钮）
  @override
  List<Widget> buildAppBarActions() {
    return [
       //your code
    ];
  }
```
4.2 我要自定义转圈咋整？
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
4.3 我要自定义错误\无数据页面咋整？
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
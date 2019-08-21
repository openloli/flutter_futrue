![big2.jpg](https://upload-images.jianshu.io/upload_images/2819106-d285dcf8b86e63bd.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

>不知道您是否还记得，刚入手Flutter时候的惊艳。
后来你是否为Json格式而苦恼，你是否已经习惯了各种括号...
随着熟悉，不习惯的总是无限放大着，像极了爱情。


那，请耐心阅读完本篇文章，让您的Flutter开发之旅回归本质: **极速构建漂亮的原生应用。**
***
在上一个项目开发的时候，产出了 [flutter_allroundrefresh 插件](https://www.jianshu.com/p/6148062cbb86) （**集下拉刷新、上拉加载、初始转圈、错误页面、异常重试、登录失效  的一条龙功能的插件**），开发的时候，只需要复制固定的代码（内部封装了刷新等逻辑及数据粗颗粒处理的逻辑）到每个页面，然后根据页面接入对应的接口（dao类，获取数据用），再然后处理数据正常时的显示、数据异常时的显示、登录失效的处理回调等情况，让开发分工于接口接入\测试，UI绘制，逻辑处理，极大的提高了团队的开发效率。

>经过一段时间沉淀后，发现这个小插件还是很难用起来，为什么呢，因为**耦合度**高的问题。
具体表现是**接口结果集格式**的高耦合，~~考虑到现在用flutter作为生产环境的公司（可能估计大概也许瞎猜的）还是相对较少~~
**不过最近看群里有小伙伴的公司都上线好几个Flutter的APP了，可喜可贺。**
估计每个公司的接口格式都不一定相同（或略有不同），甚至大部分DEMO使用了是网络上的公共API，这样的API结果集格式就算是花样百出，无法统一了，就无法在插件内部封装的高耦合数据解析方案！

所以，处理数据的逻辑必须是要暴露给开发者，或者说可定制的。
那么如何降低这个耦合，又保留[flutter_allroundrefresh](https://www.jianshu.com/p/6148062cbb86) 上的一条龙的功能呢？于是，~~我苦思冥想，顿悟了九九八十二天后~~便有了这篇文章中的新插件。
**[flutter_futrue](https://pub.dev/packages/flutter_futrue)：低耦合，更简洁，可定制接口解析方案，内部处理复杂的逻辑（额外转圈、下拉刷新、加载更多、无数据处理、网络错误处理、登录失效处理等），让开发者的重心放到UI的构建上！**（即**极速构建漂亮的原生应用**）~~ps，别问我为什么我多用了一天，因为年满十八岁的我好不容易修炼出来的金丹，居然被医院拿走了，开心过头了）~~
***

**简单的效果图：**
| 截图1：模式无内容、无网络 |  截图2：模拟返回页面时的情况
|-|-
| ![flutter_futrue_1.gif](https://upload-images.jianshu.io/upload_images/2819106-230c732f73bf4d73.gif?imageMogr2/auto-orient/strip)|![flutter_futrue_2.gif](https://upload-images.jianshu.io/upload_images/2819106-0a03f4e79f2698fa.gif?imageMogr2/auto-orient/strip)
|

[flutter_futrue](https://pub.dev/packages/flutter_futrue)使用建造者模式的概念（**把一个复杂的对象的构建与它的表示分离**） ，即把公共的复杂的逻辑、功能、构建过程进行封装，使用一些方法（页面）进行具体表现（及可重载定制化）。

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
在这里主要指Dao类，但这里仅仅是做数据的获取，不进行数据的处理。

>**View（视图层）**最主要完成前端的数据展示。
在这里主要指当前page页面，或者说页面对应的buildBody（下的ListView、GridView）及其他buildXXX方法。

>**Controller（控制层）**是对数据的接收和触发事件的接收和传递。
在这里主要指BaseState极其子类，Controller会对数据进行初步处理，用于处理数据的非正常情况的逻辑。
具体的数据整理则交给了buildBodyNoData 该方法在 View层进行处理。


2.**使用**
2.1.添加依赖

```
dependencies:
  flutter_futrue: latest_version
```
2.2.引入
```
import 'package:flutter_futrue/flutter_futrue.dart';
```

2.3.使用（完整的一个页面代码，注意 关键点：**BaseState**）

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
单从这个页面的代码来看，其实更像Android原生中的[MVP模式](https://www.jianshu.com/p/31c3909ce075)。
通常情况下，或者说项目或者DEMO使用的是标准接口（或者说和[我司接口格式](https://github.com/android-pf/flutter_futrue/blob/master/example/README.md)一致），那么使用**[flutter_futrue](https://pub.dev/packages/flutter_futrue)**架构，只需要每个页面继承 BaseState 后专心写UI即可了。

那么我前面提到：**处理数据的逻辑必须是要暴露给开发者，或者说可定制的**。
也就是说项目或者DEMO中的接口和笔者不一样，或者说嫌弃笔者审美下的转圈、空数据页面、无网络页面、甚至是刷新头，那该怎么办？。

**可扩展BaseState**:熟悉JAVA的朋友都知道[Java的三大特性](https://baijiahao.baidu.com/s?id=1618298449551241841&wfr=spider&for=pc)，这里BaseState充分利用了这个特性，使自身具备封装、继承和多态的特性。也就是说BaseState是**一个具备额外转圈、下拉刷新、加载更多、无数据处理、网络错误处理、登录失效处理等功能的父类**，如此，就好办了，**继承BaseState利用多态特性，重构具体方法达到自己想要的效果**（额外转圈、无数据处理、网络错误处理等）。

当然了，通过群里的了解，也有很多朋友不清楚Java、Android、Ios或者基础相对薄弱点，那么可以具体查看[example中的实例及文档](https://github.com/android-pf/flutter_futrue/blob/master/example/README.md)。


最后
笔者确实18岁，额，零几十个月吧，捂脸，也没有修炼出过金丹，再次捂脸。
我的FlutterQQ群：10788108
Flutter专栏QQ群：497219582
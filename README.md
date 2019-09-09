![big2.jpg](https://upload-images.jianshu.io/upload_images/2819106-d285dcf8b86e63bd.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

>不知道您是否还记得，刚入手Flutter时候的惊艳。
后来你是否为Json格式而苦恼，你是否已经习惯了各种括号...
随着熟悉，不习惯的总是无限放大着，像极了爱情。


那，请耐心阅读完本篇文章，让您的Flutter开发之旅回归本质: **极速构建漂亮的原生应用。**
***
**[flutter_futrue](https://pub.dev/packages/flutter_futrue)：是一款从进入页面开始获取数据后对数据正常或者异常时的整体解决方案。（集初始转圈、下拉刷新、上拉加载、、错误页面、异常重试、登录失效、无网络时 的一条龙功能性的插件**），开发的时候，只需要复制固定的代码（内部封装了刷新等逻辑及数据粗颗粒处理的逻辑）到每个页面，然后根据页面接入对应的接口（dao类，获取数据用），再然后处理数据正常时的显示、数据异常时的显示、登录失效的处理回调等情况，让开发分工于接口接入\测试，UI绘制，逻辑处理，极大的提高了团队的开发效率。

**注意：1.0.5属于重大更新，API有些许变化，如果项目或DEMO中没有使用到tab页面（或者说对tab返回不刷新无要求）则依然可以使用1.0.4版本，反之则需要更新。**

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
import 'package:flutter_futrue_example/net/bean/simple_bean.dart';
import 'package:flutter_futrue_example/net/net.dart';
import 'package:flutter_futrue_example/page/simple_page1_temp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';

import 'package:flutter_futrue/flutter_futrue.dart';

///
class SimplePage1 extends StatefulWidget {
  @override
  _SimplePage1State createState() => _SimplePage1State();
}

class _SimplePage1State extends BaseState<SimplePage1>
    with SingleTickerProviderStateMixin {
...
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
          title: Text('随机模拟所有情况'),
          actions: <Widget>[
            appBarMenuText(
                title: '手刷',
                onPressed: () {
                  callInitLoading();
                  onRefresh();
                }),
            appBarMenuText(
                title: '去页面-返刷新',
                onPressed: () {
                  RouteHelper.pushResultWidget(context, new SimplePage1Temp())
                      .then((result) {
                    print('result = ${result.toString()}');
                    callInitLoading();
                    onRefresh();
                  });
                }),
          ],
        ),
        body: bodyWidget(
          modelList: modelList,
          onRefresh: onRefresh,
          onLoading: onLoading,
          contentBody: body(),
        ));
  }

  void onRefresh() async {
    var path = randomPath('onRefresh');
    callRefresh(
        modelList: modelList,
        dao: HttpManager().get(
          who: 'path',
          path: path,
        ),
        dataCallback: (Object bean) {
          List<dynamic> temp = bean;
          temp.length >= 10 ? isLoading = true : isLoading = false;
          temp.forEach((v) {
            modelList.add(new SimpleDataBean.fromJson(v));
          });
        },
        tokenInvalidCallback: () {
          print('这里是处理登出的逻辑，就退出当前页吧'); //临时
          Navigator.of(context).pop(); //临时
        });
  }

  void onLoading() async {
    var path = randomPath('onLoading');
    callLoading(
        dao: HttpManager().get(
          who: path,
          path: path,
        ),
        dataCallback: (bean) {
          List<dynamic> temp = bean;
          temp.length >= 10 ? isLoading = true : isLoading = false;
          temp.forEach((v) {
            modelList.add(new SimpleDataBean.fromJson(v));
          });
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
  ///模拟获取数据时的各种情况
  randomPath(who) {...  }
}


```
单从这个页面的代码来看，其实更像Android原生中的[MVP模式](https://www.jianshu.com/p/31c3909ce075)。
通常情况下，或者说项目或者DEMO使用的是标准接口（或者说和[我司接口格式](https://github.com/android-pf/flutter_futrue/blob/master/example/README.md)一致），那么使用**[flutter_futrue](https://pub.dev/packages/flutter_futrue)**架构，只需要每个页面继承 BaseState 后专心写UI即可了。

那么我前面提到：**处理数据的逻辑必须是要暴露给开发者，或者说可定制的**。
也就是说项目或者DEMO中的接口和笔者不一样，或者说嫌弃笔者审美下的转圈、空数据页面、无网络页面、甚至是刷新头，那该怎么办？。

**可扩展BaseState**:熟悉JAVA的朋友都知道[Java的三大特性](https://baijiahao.baidu.com/s?id=1618298449551241841&wfr=spider&for=pc)，这里BaseState充分利用了这个特性，使自身具备封装、继承和多态的特性。也就是说BaseState是**一个具备额外转圈、下拉刷新、加载更多、无数据处理、网络错误处理、登录失效处理等功能的父类**，如此，就好办了，**继承BaseState利用多态特性，重构具体方法达到自己想要的效果**（额外转圈、无数据处理、网络错误处理等）。

当然了，通过群里的了解，也有很多朋友不清楚Java、Android、Ios或者基础相对薄弱点，那么可以具体查看[example中的实例及文档](https://github.com/android-pf/flutter_futrue/blob/master/example/README.md)。


最后
笔者最近刚出院，文档会尽快补齐。有什么问题群里有问必答。
我的FlutterQQ群：10788108
Flutter专栏QQ群：497219582
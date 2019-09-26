![big2.jpg](https://upload-images.jianshu.io/upload_images/2819106-d285dcf8b86e63bd.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

>不知道您是否还记得，刚入手Flutter时候的惊艳。
后来你是否为Json格式而苦恼，你是否已经习惯了各种括号
...
随着熟悉，不习惯的总是无限放大着，像极了爱情。


阅读完本篇文章，让您的Flutter开发之旅回归本质: **极速构建漂亮的原生应用。**

**[flutter_futrue](https://pub.dev/packages/flutter_futrue)：是一款从进入页面开始获取数据后对数据正常或者异常时的整体解决方案。（集转圈、下拉刷新、上拉加载、数据为空、服务器异常、重试、登录失效、无网络时 的一条龙功能性的插件**）
***

1.**简单的效果图：**
| 截图1：模式无内容、无网络 |  截图2：模拟返回页面时的情况
|-|-
| ![flutter_futrue_1.gif](https://upload-images.jianshu.io/upload_images/2819106-230c732f73bf4d73.gif?imageMogr2/auto-orient/strip)|![flutter_futrue_2.gif](https://upload-images.jianshu.io/upload_images/2819106-0a03f4e79f2698fa.gif?imageMogr2/auto-orient/strip)
|
***
[flutter_futrue](https://pub.dev/packages/flutter_futrue)使用建造者模式的概念（**把一个复杂的对象的构建与它的表示分离**） ，即把公共的复杂的逻辑、功能、构建过程进行封装，使用一些方法（页面）进行具体表现（及可重载定制化）。

极简又规范开发流程：
1.把当前页面extends State更改为extends  BaseState（内部封装了刷新等逻辑及数据粗颗粒处理等逻辑），
2.书写onRefresh/onLoading方法，使用当前页面对应的接口获取数据，处理具体数据（数据正常时、数据为空时，服务器异常时、手机无网络等情况），
3.书写onBody方法，选择是ListView或GridView及具体Item绘制。
如此，让开发分工于接口接入\测试，UI绘制，逻辑处理，极大的提高了团队的开发效率。

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

2.3.1把当前页面extends State更改为extends  BaseState
```
...
class _SimplePage1State extends BaseState<SimplePage1>
...
```

2.3.2书写onRefresh/onLoading方法
```
...
void onRefresh() async {
    callRefresh(
        modelList: modelList,
        dao: HttpManager().get( ),//data api
        dataCallback: (Object bean) {
          //normal data processing
        },
        tokenInvalidCallback: () {
          //login invalidation processing
        });
  }
  void onLoading() async { ... }
...
```
2.3.3书写onBody方法
```
...
  Widget onBody() {
    return ListView.builder(
      itemCount: modelList.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
           //your listview item ui
      );
      },
    );
  }
...
```
通常情况下，或者说项目或者DEMO使用的是标准接口（或者说和[我司接口格式](https://github.com/android-pf/flutter_futrue/blob/master/example/README.md)一致），那么使用**[flutter_futrue](https://pub.dev/packages/flutter_futrue)**架构，只需要每个页面继承 BaseState 后专心写UI即可了。


如果说项目或者DEMO中的接口和笔者不一样，或者说嫌弃笔者审美下的转圈、空数据页面、无网络页面、甚至是刷新头，那该怎么办？。

**可扩展BaseState**:熟悉JAVA的朋友都知道[Java的三大特性](https://baijiahao.baidu.com/s?id=1618298449551241841&wfr=spider&for=pc)，这里BaseState充分利用了这个特性，使自身具备封装、继承和多态的特性。也就是说想用自己的转圈、或者错误页面、数据处理等情况只需要继承BaseState后重构具体方法就可以了，比如：
```
abstract class LHBaseState<T extends StatefulWidget> extends BaseState<T> {
  initProgressWidget() {
     return Container(
      child: Text('custom loading'),
    );
  }

  initErrorWidget() {
    return Container(
      child: Text('custom error widget：$errorMsg'),
    );
  }
}
```

**注意：1.0.5属于重大更新，API有许多变化，如果项目或DEMO中没有使用到tab页面（或者说对tab返回不刷新无要求）则依然可以使用1.0.4版本，反之则需要更新。**

当然了，通过群里的了解，也有很多朋友不清楚Java、Android、Ios或者基础相对薄弱点，那么可以具体查看[example中的实例及文档](https://github.com/android-pf/flutter_futrue/blob/master/example/README.md)。


最后
笔者最近刚出院，文档会尽快补齐。有什么问题群里有问必答。
我的FlutterQQ群：10788108
Flutter专栏QQ群：497219582
![百花齐放](https://upload-images.jianshu.io/upload_images/2819106-d285dcf8b86e63bd.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
***
语言 ： [中文](https://github.com/android-pf/flutter_futrue/blob/master/README.md)  |  [English](https://github.com/android-pf/flutter_futrue/blob/master/README_EN.md)


### [Flutter Futrue](https://pub.dev/packages/flutter_futrue)
***
针对Flutter(Android、IOS)项目，从进入页面开始获取数据，对数据正常\异常时的整体解决方案。

正式项目:
下载链接| [Android](https://sj.qq.com/myapp/detail.htm?apkName=com.futurenavi.pilot) |[IOS](https://apps.apple.com/cn/app/id1471076437?l=zh&ls=1&mt=8)
:---:|:---:|:---:
二维码|![](https://raw.githubusercontent.com/android-pf/flutter_futrue/master/example/assets/qr/android-tea.png)|![](https://github.com/android-pf/flutter_futrue/blob/master/example/assets/qr/ios-tea.png?raw=true)

***
**flutter_futrue 特点**

- 半自动处理网络断开、服务器超时、数据为空、登录失效等情况 。
- 可根据结果集类型定制半自动处理逻辑（耦合不同的格式的JSON结果集）。
- 可自定义错误页面（含重试功能）。
- 可自定义转圈页面(随时呼出)。
- 初入页面时呼出默认转圈。
- 下拉刷新数据。
- 上拉加载更多数据。
 ***
#### 效果图
| 模式无内容、无网络 |  模拟返回页面时的情况
|-|-
| ![flutter_futrue_1.gif](https://upload-images.jianshu.io/upload_images/2819106-230c732f73bf4d73.gif?imageMogr2/auto-orient/strip)|![flutter_futrue_2.gif](https://upload-images.jianshu.io/upload_images/2819106-0a03f4e79f2698fa.gif?imageMogr2/auto-orient/strip)|
***
## 使用
1. 添加依赖

```
dependencies:
  flutter_futrue: latest_version
```
2. 引入
```
import 'package:flutter_futrue/flutter_futrue.dart';
```
3. 替换当前页面extends State更改为extends  BaseState
```
...
//class _YourPageName extends State<YourPageName>{...}
class _YourPageName extends BaseState<YourPageName>{...}
...
```
4. 在build中的使用
```
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(... ),
      body: bodyWidget(
        modelList: modelList,
        onRefresh: onRefresh,
        onLoading: onLoading,
        contentBody: body(),
      ),
    );
  }
...
```
5. onRefresh（onLoading）获取数据的封装
```
  void onRefresh() async {
    callRefresh(
      modelList: modelList,
      dao: yourGetDataInterfaceMethod(),
      dataCallback: (Object bean) {
       //当前页面的数据处理，注意bean的类型取决于yourGetDataInterfaceMethod
      },
      tokenInvalidCallback: (msg) =>
          defaultHandlingTokenInvalid(context, msg: msg,page:new Login()),
    );
  }
...
```
***
##### 总结了一下开发流程（极简、规范）：
1.把当前页面extends State更改为extends  BaseState（内部封装了刷新等逻辑及数据粗颗粒处理等逻辑）。
2.在build中使用bodyWidget方法。
3.书写onRefresh/onLoading方法，使用当前页面对应的接口获取数据，处理具体数据（数据正常时、数据为空时，服务器异常时、手机无网络等情况）。
4.书写onBody方法，选择是ListView或GridView及具体Item绘制。
如此，让开发分工于接口接入\测试，UI绘制，逻辑处理，极大的提高了团队的开发效率。

### 传送门
- [github地址](https://github.com/android-pf/flutter_futrue)
- [插件默认的JSON格式是什么样的，其他格式的数据如何定制BaseState？](https://github.com/android-pf/flutter_futrue/blob/master/example/README.md)
- [如何定制默认转圈？如何定制错误页面](https://github.com/android-pf/flutter_futrue/blob/master/example/README_PROBLEM.md)
- [常见问题](https://github.com/android-pf/flutter_futrue/blob/master/example/README_WIDGET.md)


>联系方式
我的FlutterQQ群：10788108
Flutter专栏QQ群：497219582
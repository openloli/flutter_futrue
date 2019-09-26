# flutter_future 自定义锦集

可自定义项
- 转圈
- 错误页面
- JSON半自动处理
- 刷新头布局
- 加载更多布局

1. 自定义转圈
```dart
abstract class YourBaseState<T extends StatefulWidget> extends BaseState<T> {
  initProgressWidget() {
    return yourProgressWidget();
  }
}
```
>1、新建你的YourBaseState 类。
2、需要extends BaseState<T>。
3、重写initProgressWidget()方法。

参考如下：
```dart
class MyProgress2Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        width: 80.0,
        height: 80.0,
        child: Image.asset( "assets/images/xiaoxin.gif",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
```
2. 自定义错误页面
```dart
abstract class YourBaseState<T extends StatefulWidget> extends BaseState<T> {
  initErrorWidget() {
    return Container(
      alignment: Alignment.center,
      width: 200.0,
      height: 120.0,
      color: Colors.green[300],
      child: Text('$errorMsg'),
    );
  }
}
```
>1、新建你的YourBaseState 类。
2、需要extends BaseState<T>。
3、重写initErrorWidget()方法。

3.JSON半自动处理
 ```dart
abstract class YourBaseState<T extends StatefulWidget> extends BaseState<T> {
   ///使用刷新处理器
  void callRefresh({
    Object model,
    List<Object> modelList,
    dao,
    dataCallback,
    tokenInvalidCallback,
    other = false,
  }) async {
    callLoadComplete();
    Future.delayed(const Duration(milliseconds: 2000)).then((val) {
      dao.then((result) {
       //根据实际JSON格式参考源码进行定制
      },
      );
    });
  }
}
```
4.刷新头布局
5.加载更多布局
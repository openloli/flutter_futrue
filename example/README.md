# flutter_future example 说明文档

需要说明的是，该插件不适合使用集合了多方API（这里指JSON格式不一致的）

1. 我的环境(mac+win10台式)

   ```dart
   Flutter: 1.9
   Java sdk: 8
   Android Studio: 3.4.2
   Android Tools: 3.4.2
   Gradle: gradle-5.1.1-all.zip
   ```

2. 我司接口格式
``` dart
   {
       "msg": "查找成功",
       "ver": "1.5.0",
       "data": [],
       "success": true,
       "code": "200"
   }
   ```
>核心字段：msg、code、data（注意：  "data":{}或  "data":[]）


3. 完整页面的使用

``` dart
...
import 'package:flutter_futrue/flutter_futrue.dart';
class SimplePage1 extends StatefulWidget {
  @override
  _SimplePage1State createState() => _SimplePage1State();
}

class _SimplePage1State extends BaseState<SimplePage1>
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
      appBar: AppBar( title: Text('随机模拟所有情况') ),
      body: bodyWidget(
        modelList: modelList,
        onRefresh: onRefresh,
        onLoading: onLoading,
        contentBody: body(),
      ),
    );
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
        temp.length >= 10 ? isLoading = true : isLoading = false;
        temp.forEach((v) {
          modelList.add(new SimpleDataBean.fromJson(v));
        });
      },
      tokenInvalidCallback: (msg) =>
      defaultHandlingTokenInvalid(context, msg: msg,page:new Login),
    );
  }

  void onLoading() async {
    var path = Api.randomPath('onLoading');
    callLoading(
      dao: HttpManager().get(
        who: path,
        path: path,
      ),
      dataCallback: (Object bean) {
        List<dynamic> temp = bean;
        temp.length >= 10 ? isLoading = true : isLoading = false;
        temp.forEach((v) {
          modelList.add(new SimpleDataBean.fromJson(v));
        });
      },
        tokenInvalidCallback: (msg) {
          print('根据自己项目的需求处理token失效');
          Navigator.of(context).pop();
        },
    );
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
```
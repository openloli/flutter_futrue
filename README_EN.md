![Hundred flowers](https://upload-images.jianshu.io/upload_images/2819106-d285dcf8b86e63bd.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
***
Language ： [中文](https://github.com/android-pf/flutter_futrue/blob/master/README.md)  |  [English](https://github.com/android-pf/flutter_futrue/blob/master/README_EN.md)


### [Flutter Futrue](https://pub.dev/packages/flutter_futrue)

For the Flutter (Android, IOS) project, get the data from the entry page, the overall solution for the data normal\abnormal.

![before and after using flutter_futrue](https://upload-images.jianshu.io/upload_images/2819106-254af4e58fc8331b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

From the above figure, you can find [flutter_futrue](https://pub.dev/packages/flutter_futrue)** is to `encapsulate some of the things and situations after you open the page and access the network data. Corresponding data processing (ListView drawing Item), corresponding data after data anomaly (with self-reloading function), processing of login failure, and encapsulation of corresponding interface API**. Relatively reduced development and page code.


Formal project:   [Android](https://sj.qq.com/myapp/detail.htm?apkName=com.futurenavi.pilot) 、[IOS](https://apps.apple.com/cn/app/id1471076437?l=zh&ls=1&mt=8)

|Android|IOS
|-|-
|![](https://raw.githubusercontent.com/android-pf/flutter_futrue/master/example/assets/qr/android-tea.png)|![](https://github.com/android-pf/flutter_futrue/blob/master/example/assets/qr/ios-tea.png?raw=true)

***
**flutter_futrue Characteristics**

- Semi-automatic processing of network disconnection, server timeout, data empty, login failure, etc.
- Semi-automatic processing logic (coupling JSON result sets in different formats) can be customized based on the result set type.
- Customizable error page (including retry function).
- Customizable circle page (call out at any time).
- Call out the default circle when you first enter the page.
- Pull down to refresh the data.
- Pull up to load more data.
 ***
#### Rendering
| Mode no content, no network |  Simulate the situation when returning to the page
|-|-
| ![](https://upload-images.jianshu.io/upload_images/2819106-230c732f73bf4d73.gif?imageMogr2/auto-orient/strip)|![](https://upload-images.jianshu.io/upload_images/2819106-0a03f4e79f2698fa.gif?imageMogr2/auto-orient/strip)|
***
## use
1. Add dependency

```dart
dependencies:
  flutter_futrue: latest_version
```
2. import
```dart
import 'package:flutter_futrue/flutter_futrue.dart';
```
3. Replace the current page extends State with extends BaseState (or your xxBaseState)
```dart
...
//class _YourPageName extends State<YourPageName>{...}
class _YourPageName extends BaseState<YourPageName>{...}
...
```
4. Use bodyWidget in build
```dart
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
5. onRefresh(onLoading) gets the encapsulation of the data
```dart
  void onRefresh() async {
    callRefresh(
      modelList: modelList,
      dao: yourGetDataInterfaceMethod(),
      dataCallback: (Object bean) {
       //Data processing of the current page,
       //note that the type of the bean depends on yourGetDataInterfaceMethod
      },
      tokenInvalidCallback: (msg) =>
          defaultHandlingTokenInvalid(context, msg: msg,page:new Login()),
    );
  }
...
```
***
##### Summarized the development process (minimal, standard)：
1.Change the current page extends state to extends BaseState (internally encapsulates logic such as refresh and data coarse grain processing).
2.Use the bodyWidget method in the build.
3.Write the onRefresh/onLoading method, use the interface corresponding to the current page to obtain data, and process the specific data (when the data is normal, when the data is empty, when the server is abnormal, the mobile phone has no network, etc.).
4.Write the onBody method, select the ListView or GridView and draw the specific Item.
In this way, let the development division of labor in the interface access \ test, UI drawing, logic processing, greatly improving the team's development efficiency.

### Portal
- [github line](https://github.com/android-pf/flutter_futrue)
- [What is the default JSON format of the plugin, and how to customize BaseState in other formats?](https://github.com/android-pf/flutter_futrue/blob/master/example/README.md)
- [How to customize the default circle? How to customize the error page](https://github.com/android-pf/flutter_futrue/blob/master/example/README_PROBLEM.md)
- [common problem](https://github.com/android-pf/flutter_futrue/blob/master/example/README_WIDGET.md)


#### Contact information
My Flutter QQ group: 10788108
Flutter column QQ group: 497219582
import 'dart:math';

class Api {
  static var apiData10 =
      "http://www.mocky.io/v2/5d25615d2f00006400c10754"; //  十条数据
  static var apiData3 =
      "http://www.mocky.io/v2/5d25892f2f00009136c10841"; // 三条数据
  static var apiData0 =
      "http://www.mocky.io/v2/5d2596052f00000a35c108c7"; //数据为空
  static var apiData900 =
      "http://www.mocky.io/v2/5d25968c2f00004834c108d1"; //登录失效

  ///模拟获取数据时的各种情况
  static randomPath(who) {
    var random = Random().nextInt(5);
    print('$who，random = $random (0、4模拟10条、1模拟3条、2模拟0条、3模拟登录失效)');
    if (random == 0 || random == 4) {
      return Api.apiData10;
    } else if (random == 1) {
      return Api.apiData3;
    } else if (random == 2) {
      return Api.apiData0;
    } else if (random == 3) {
      return Api.apiData900;
    } //临时
  }
}

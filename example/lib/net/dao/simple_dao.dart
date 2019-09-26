import 'dart:async';
import 'package:flutter_futrue_example/net/api.dart';
import 'package:flutter_futrue_example/net/net.dart';

class SimpleDao {
  ///十条数据1
  static Future<dynamic> getData10({page}) async {
    return HttpManager().get(
      who: 'getData10',
      path: Api.apiData10,
    );
  }

  /// 三条数据
  static Future<dynamic> getData4({page}) async {
    return HttpManager().get(
      who: 'getData4',
      path: Api.apiData3,
    );
  }

  ///没有数据
  static Future<dynamic> getData0({page}) async {
    return HttpManager().get(
      who: 'getData0',
      path: Api.apiData0,
    );
  }

  ///登录失效重新登录
  static Future<dynamic> getData900({page}) async {
    return HttpManager().get(
      who: 'API_date900',
      path: Api.apiData900,
    );
  }
}

import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_futrue/flutter_futrue.dart';
import 'package:flutter_futrue_example/page/simple_page/simple_page13.dart';

class BarPage1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _BarPage1State();
  }
}

class _BarPage1State extends BaseState<BarPage1> {


  @override
  buildBody() {
    return GridView.builder(

      padding: EdgeInsets.only(top: 2.0, left: 2.0, right: 2.0),
      itemCount: modelList.length,
      itemBuilder: (context, i) {
        GanHuo itemBean = modelList[i];
        return new Material(
          elevation: 4.0,

          borderRadius: new BorderRadius.all(new Radius.circular(4.0)),
          child: new InkWell(
              onTap: () {

              },
              child:
              new Container(
                alignment: Alignment.center,
                child: Text('${itemBean.url}'),
              )
          ),
        );
      },
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
        crossAxisCount: 2,
      ),
    );
  }


  CancelToken _token = new CancelToken();
  List<GanHuo> modelList = [];

  xxx({page = 2, isLoad = false}) async {
    try {
      var size = 10;
      print('page = $page,,isLoad = $isLoad');
      var path = 'http://gank.io/api/data/all/$size/$page';
      Dio dio = new Dio();
      Response response = await dio.get(path, cancelToken: _token);
      if (response != null && response.data != null) {
        CommBean ganHuos = CommBean.fromJson(response.data);
        if (ganHuos != null) {
//          List<dynamic> temp = new Map<String, dynamic>.from(ganHuos.results);
          List<dynamic> temp = ganHuos.results;
          if (temp != null) {
            temp.forEach((v) {
              modelList.add(new GanHuo.fromJson(v));
            });
            if (modelList.length > 0) {
              dataHelper(type: DataState.normal);
            } else {
              dataHelper(type: DataState.noData);
            }
            print('2 = ${modelList.length}');
          } else {
            dataHelper(type: DataState.catched);
          }
        } else {
          dataHelper(type: DataState.catched);
        }
      } else {
        dataHelper(type: DataState.catched);
      }
      return response.data;
    } catch (e) {
      print('11111$e');
      return null;
    }
  }

  @override
  Future<dynamic> refresh() {
    modelList.clear();
//    isLoadMore=false;
    return xxx();
  }

  var page = 1;

  @override
  Future<dynamic> loading() {
//    isLoadMore=true;
    return xxx(page: page++, isLoad: true);
  }

  @override
  void useNetData(Object data) {
    // 假数据用不到该方法
  }

}



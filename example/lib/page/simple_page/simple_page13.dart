import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_futrue/flutter_futrue.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SimplePage13 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SimplePage13State();
  }
}

class _SimplePage13State extends BaseState<SimplePage13> {
  @override
  String appBarTitle() {
    return '假数据示范';
  }

  @override
  List<Widget> buildAppBarActions() {
    return [
      IconButton(
        icon: Icon(Icons.refresh), onPressed: () {
        showLoading();
        Future.delayed(const Duration(milliseconds: 1000)).then((val) {
          refresh();
        });
      },),
    ];
  }

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
                child: CachedNetworkImage(imageUrl: itemBean.url),
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

  xxx({page = 1, isLoad = false}) async {
    try {
      var size = 8;
      print('page = $page,,isLoad = $isLoad');
      var path = 'http://gank.io/api/data/福利/$size/$page';
      Dio dio = new Dio();
      Response response = await dio.get(path, cancelToken: _token);
      if (response != null && response.data != null) {
        CommBean ganHuos = CommBean.fromJson(response.data);
        if (ganHuos != null) {
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

class GanHuo extends Object {
  String createdAt;
  String desc;
  String type;
  String url;
  String publishedAt;
  List<String> images;
  String who;
  String source;
  bool used;

  GanHuo(this.createdAt, this.desc, this.type, this.url,
      this.publishedAt, this.images, this.who, this.source, this.used);

  GanHuo.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    desc = json['desc'];
    type = json['type'];
    url = json['url'];
    publishedAt = json['publishedAt'];
    images = json['images'];
    who = json['who'];
    source = json['source'];
    used = json['used'];
  }
}


class CommBean extends Object {
  bool error;
  Object results;

  CommBean(this.error, this.results);

  CommBean.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    results = json['results'];
  }
}
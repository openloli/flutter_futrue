import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_futrue/src/base/base_view.dart';
import 'package:flutter_futrue/src/bean/comm_bean.dart';
import 'package:flutter_futrue/src/helper/loading_helper.dart';

/**
 * Core class
 * Use polymorphism and overloading
 * Encapsulate common page styles
 * Package refresh plugin
 * Package data processing
 * Package turn effect
 * Adapt the title, floating window in the upper right corner, etc.
 */

///
enum DataState { normal, noData, noNetwork, catched }

abstract class BaseState<T extends StatefulWidget> extends State<T>
    implements IBaseView {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  String title = "";
  bool isLoading = false, isRefresh = true, isLoadMore = true;
  DataState state;
  var errorMsg,
      normalCode = '200',
      noDataCode = '404',
      tokenInvalidCode = '900';

  @override
  void initState() {
    initData();
    init();
    super.initState();
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: title.isEmpty
          ? null
          : new AppBar(
              actions: buildAppBarActions(),
              title: new Text(title),
            ),
      body: SmartRefresher(
        enablePullDown: isRefresh,
        enablePullUp: isLoadMore,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("点击重试");
            } else {
              body = Text("没有更多数据了");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: refreshController,
        onRefresh: refresh,
        onLoading: loading,
        child: state == DataState.normal
            ? buildBody()
            : state == DataState.noData
                ? buildBodyNoData()
                : buildBodyNoNetwork(),
      ),
      floatingActionButton: buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomPadding: false,
    );
  }

  buildBodyNoData() {
    return GestureDetector(
      child: Center(
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width - 100.0,
          height: MediaQuery.of(context).size.height / 4,
          color: Colors.blue,
          child: Text(
            '没有内容',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      onTap: () {
        refreshController.requestRefresh();
      },
    );
  }

  buildBodyNoNetwork() {
    return GestureDetector(
      child: Center(
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width - 100.0,
          height: MediaQuery.of(context).size.height / 4,
          color: Colors.green,
          child: Text(
            '没有网络或者服务器超时',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      onTap: () {
        refreshController.requestRefresh();
      },
    );
  }

  void dataHelper({DataState type, isLoad = false}) {
    if (isLoad) {
      loadHelper(type);
    } else {
      refreshHelper(type);
    }
  }

  void refreshHelper(DataState type) {
    state = type;
    refreshController.loadComplete();
    if (type == DataState.normal) {
      refreshController.refreshCompleted();
    } else if (type == DataState.noData) {
      refreshController.refreshFailed();
    } else if (type == DataState.noNetwork) {
      refreshController.refreshFailed();
    } else if (type == DataState.catched) {
      refreshController.refreshFailed();
    }
    setState(() {});
  }

  void loadHelper(DataState type) {
    if (type == DataState.normal) {
      refreshController.loadComplete();
    } else if (type == DataState.noData) {
      refreshController.loadNoData();
    } else if (type == DataState.noNetwork) {
      refreshController.loadFailed();
    }
    setState(() {});
  }

  Future<dynamic> refresh() async {
    isLoadMore = true;
    state = DataState.normal;
    refreshController.loadComplete();
    await onRefresh().then((result) {
      hideLoading();
      if (result != null) {
        CommBean bean = CommBean.fromJson(result);
        if (bean.data == null || bean.data == '') {
          refreshController.refreshFailed();
        } else {
          refreshController.refreshCompleted();
          if (bean.code == normalCode) {
            useNetData(bean.data);
          } else if (bean.code == noDataCode) {
            refreshController.refreshFailed();
            state = DataState.noData;
          } else if (bean.code == tokenInvalidCode) {
            refreshController.refreshFailed();
            state = DataState.noData;
          } else {
            refreshController.refreshFailed();
            state = DataState.noData;
          }
        }
      } else {
        refreshController.refreshFailed();
        state = DataState.noNetwork;
      }
    });
  }

  Future<dynamic> loading() async {
    if (onLoading() != null) {
      Future.delayed(const Duration(milliseconds: 1000)).then((val) {
        onLoading().then((result) {
          if (result != null) {
            if (result.toString().contains('isLoading')) {
              refreshController.loadNoData();
            } else {
              CommBean bean = CommBean.fromJson(result);
              if (bean.data == null || bean.data == '') {
                refreshController.loadFailed();
              } else {
                if (bean.code == normalCode) {
                  refreshController.loadComplete();
                  useNetData(bean.data);
                } else if (bean.code == noDataCode) {
                  refreshController.loadNoData();
                }
              }
            }
          } else {
            refreshController.loadFailed();
          }
        });
      });
    } else {
      refreshController.loadFailed();
    }
  }

  void useNetData(Object data) {}

  Future<dynamic> onRefresh() async {}

  Future<dynamic> onLoading() async {
    Map<String, dynamic> temp = {'isLoading': 'false'};
    return temp;
  }

  void init() {}

  void initData() {
    state = DataState.normal;
    this.title = appBarTitle();
  }

  String appBarTitle() {
    return "";
  }

  List<Widget> buildAppBarActions() {
    return null;
  }

  Widget buildBodyHead() {
    return Container(
      height: 0.0,
    );
  }

  buildBody() {
    return null;
  }

  Widget buildBodyFoot() {
    return Container(
      height: 0.0,
    );
  }

  Widget buildFloatingActionButton() {
    return null;
  }

  @override
  showToast(String message) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(message)));
  }

  @override
  void showLoading() {
    if (!isLoading) {
      isLoading = true;
      CommonUtils.showLoadingDialog(context);
    }
  }

  @override
  void hideLoading() {
    if (isLoading) {
      isLoading = false;
      Navigator.of(context).pop();
    }
  }
}

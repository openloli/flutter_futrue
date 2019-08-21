import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_futrue/flutter_futrue.dart';

abstract class BaseStateForNoRefresh<T extends StatefulWidget>
    extends BaseState<T>
    implements IBaseView {


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
      body: buildBody(),
      floatingActionButton: buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomPadding: false,
    );
  }
}
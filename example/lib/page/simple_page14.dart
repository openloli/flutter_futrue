import 'dart:math';
import 'package:flutter_futrue_example/net/bean/simple_bean.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_futrue/flutter_futrue.dart';
import 'package:flutter_futrue_example/page/temp/calendar_page_viewModel.dart';
import 'package:flutter_futrue_example/page/temp/calendar_widget.dart';

///
class SimplePage14 extends StatefulWidget {
  @override
  _SimplePage14State createState() => _SimplePage14State();
}

class _SimplePage14State extends BaseState<SimplePage14>
    with SingleTickerProviderStateMixin {
  List<SimpleDataBean> modelList = [];
  bool isPrint = true;
  TextEditingController editingController;
  CalendarItemViewModel itemList2;

  @override
  void initState() {
    editingController = new TextEditingController();
//    _list = CalendarViewModel().getItemList();
    currentDay = (Random().nextInt(27)) + 1;
    itemList2 = CalendarViewModel().getItemList3(currentDay);
    super.initState();
  }

  @override
  void dispose() {
    refreshController.dispose();
    editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    MediaQuery.of(context).size.width - 70.0
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '搜索',
          ),
          onSubmitted: (key) {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 20.0,
            color: Theme.of(context).primaryColor,
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0, top: 10.0),
            child: Container(
              padding: EdgeInsets.only(left: 10.0),
              child: Center(
                child: Form(
                  autovalidate: true,
                  child: TextFormField(
                      cursorRadius: Radius.elliptical(2, 20),
                      textInputAction: TextInputAction.search,
                      controller: editingController,
                      style: TextStyle(color: Colors.teal),
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        prefixIcon: new Icon(Icons.search),
                        suffixIcon: GestureDetector(
                          child: Icon(Icons.cancel),
                          onTap: () {},
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                        contentPadding: EdgeInsets.only(top: 10.0),
                        fillColor: Theme.of(context).primaryColor,
                        hintText: '请输入',
                        hintStyle: TextStyle(color: Colors.black45),
                        filled: false,
                      ),
                      onFieldSubmitted: (value) {
//                        submitCallback(value);
                      }),
                ),
              ),
            ),
            width: MediaQuery.of(context).size.width - 60,
            height: 35.0,
          ),
//          WidgetHelper.commSearchWidget(context, editingController,
////                frameWidth: MediaQuery.of(context).size.width - 120,
////                inputWidth: MediaQuery.of(context).size.width - 120 - 55.0,
//              inputStyleStyle: TextStyle(color: Colors.red), cleanCallback: () {
//            print('cleanCallback');
//          }, cancelCallback: () {
//            print('cancelCallback1111');
//            Navigator.of(context).pop();
//          }),
//          Material(
//            color: Colors.brown,
//            child: WidgetHelper.commSearchWidget(context, editingController,
////                frameWidth: MediaQuery.of(context).size.width - 120,
////                inputWidth: MediaQuery.of(context).size.width - 120 - 55.0,
//                cleanCallback: () {
//              print('cleanCallback');
//            }, cancelCallback: () {
//              print('cancelCallback1111');
//              Navigator.of(context).pop();
//            }),
//          ),
//          Container(
//            margin: EdgeInsets.only(top: 10.0),
//            child: WidgetHelper.commSearchWidget(context, editingController,
//                cleanCallback: () {
//              print('cleanCallback');
//            }, cancelCallback: () {
//              print('cancelCallback1111');
//              Navigator.of(context).pop();
//            }),
//          ),
//          Container(
//            height: 60.0,
//            color: Theme.of(context).primaryColor,
//            child: Row(
//              children: <Widget>[
//                Container(
//                  margin: EdgeInsets.only(left: 12.0, right: 5.0),
//                  padding: EdgeInsets.only(left: 10.0),
//                  height: 30.0,
//                  width: MediaQuery.of(context).size.width - 70.0,
//                  decoration: BoxDecoration(
//                      color: Color(0xFFEEEEEE),
//                      borderRadius:
//                          BorderRadius.all(const Radius.circular(5.0))),
//                  child: Row(
//                    children: <Widget>[
//                      Icon(
//                        Icons.search,
//                        size: 22.0,
//                        color: Colors.black54,
//                      ),
//                      Container(
//                        child: Container(
//                          padding: new EdgeInsets.only(left: 10.0),
//                          child: Center(
//                            child: Form(
//                              autovalidate: true,
//                              child: TextFormField(
//                                  textInputAction: TextInputAction.search,
//                                  controller: editingController,
//                                  style: new TextStyle(color: Colors.teal),
//                                  textAlign: TextAlign.start,
//                                  decoration: InputDecoration.collapsed(
//                                    fillColor: Theme.of(context).primaryColor,
//                                    hintText: '请输入关键字',
//                                    hintStyle: TextStyle(color: Colors.black45),
//                                    filled: false,
//                                  ),
//                                  onFieldSubmitted: (value) {
//                                    print('搜索按钮？${value}');
//                                  }),
//                            ),
//                          ),
//                        ),
//                        width: MediaQuery.of(context).size.width - 128.0,
//                      ),
//                      GestureDetector(
//                        child: Icon(
//                          Icons.cancel,
//                          size: 20.0,
//                          color: Colors.black54,
//                        ),
//                        onTap: () {
//                          print('搜索按钮？22222');
//                        },
//                      ),
//                    ],
//                  ),
//                ),
//                GestureDetector(
//                  child: Container(
//                    margin: EdgeInsets.only(left: 10.0),
//                    child: Text(
//                      '取消',
//                      style: TextStyle(fontSize: 14.0, color: Colors.white),
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          ),
        ],
      ),
    );
  }

//  List<CalendarItemViewModel> _list = [];
  int currentDay = 1;

  tempWidget() {
    print('currentDay $currentDay');
    return Container(
//      height: screenHeight - 64 - 80 - 83 - 30,
      child: CalendarItem(
          (year, month, checkInTime) {
//              _updateCheckInLeaveTime(year, month, checkInTime);
          },
          itemList2,
          currentDay,
          callRight: () {
            itemList2 = null;
            currentDay = (Random().nextInt(27)) + 1;
            itemList2 = CalendarViewModel().getItemList3(currentDay);
            print('currentDay $currentDay');
            setState(() {});
          },
          callLeft: () {
            itemList2 = null;
            currentDay = (Random().nextInt(27)) + 1;
            itemList2 = CalendarViewModel().getItemList3(currentDay);
            print('currentDay $currentDay');
            setState(() {});
          }),
//      child: ListView.builder(
//        itemBuilder: (BuildContext context, int index) {
//          CalendarItemViewModel itemModel = _list[index];
//          return CalendarItem(
//            (year, month, checkInTime) {
////              _updateCheckInLeaveTime(year, month, checkInTime);
//            },
//            itemModel,
//          );
//        },
//        itemCount: _list.length,
//      ),
    );
  }

  chooseBirthday() async {
    showDatePicker(
      context: context,
      initialDate: new DateTime.now().subtract(new Duration(days: 10950)),
//      initialDate: birthday != ''
//          ? DateTime.parse(birthday)
//          : new DateTime.now().subtract(new Duration(days: 10950)),
      // 默认老师26岁
      firstDate: new DateTime.now().subtract(new Duration(days: 23725)),
      // 默认老师65退休
      lastDate: new DateTime.now().add(new Duration(days: 30)), // 加 30 天
    ).then((DateTime val) {
//      var today = DateTime.now();
//      if (val.millisecondsSinceEpoch >
//          today.subtract(new Duration(days: 1)).millisecondsSinceEpoch) {
//        ToastHelper.showOKToast('不能选择当前日期');
//        user.birthday = birthday;
//      } else {
//        user.birthday = val.toString().substring(0, 10);
//        print('日期选择 ${user.birthday}'); // 2018-07-12 00:00:00.000
//        birthday = val.toString().substring(0, 10);
//        print('日期选择 ${birthday}'); // 2018-07-12 00:00:00.000
//        setState(() {});
//      }
    }).catchError((err) {
      print('日期选择 err $err');
    });
  }
}

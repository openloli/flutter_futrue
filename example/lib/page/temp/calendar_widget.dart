import 'package:flutter/material.dart';
import 'package:flutter_futrue_example/page/temp/time_utils.dart';

import 'calendar_page_viewModel.dart';

typedef void OnTapDayItem(int year, int month, int checkInTime);

// ignore: must_be_immutable
class CalendarItem extends StatefulWidget {
   CalendarItemViewModel itemModel;
  final OnTapDayItem dayItemOnTap;
  final int currentDay;
  final Function callRight;
  final Function callLeft;

  CalendarItem(this.dayItemOnTap, this.itemModel, this.currentDay,
      {this.callRight, this.callLeft});

  @override
  _CalendarItemState createState() => _CalendarItemState();
}

class _CalendarItemState extends State<CalendarItem> {
  // 日历显示几行
  int _rows = 0;
  List<DayModel> _listModel = <DayModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listModel = widget.itemModel.list;
  }

  @override
  Widget build(BuildContext context) {
    double screenWith = MediaQuery.of(context).size.width;
    // 显示几行
    _rows = TimeUtil.getRowsForMonthYear(widget.itemModel.year, widget.itemModel.month, MaterialLocalizations.of(context));

    return Container(
      width: screenWith,
      height: 25.0 + 24.0 + 17.0 + _rows * 52.0 + 32.0 + 36,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 32,
          ),
          _yearMonthItem(widget.itemModel.year, widget.itemModel.month),
          SizedBox(
            height: 24,
          ),
          _weekItem(screenWith),
          SizedBox(
            height: 13,
          ),
          _monthAllDays(widget.itemModel.year, widget.itemModel.month, context),
        ],
      ),
    );
  }

  bool isOpen = false;

  /*
  * 显示年月的组件，需要传入年月日期
  * */
  _yearMonthItem(int year, int month) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.center,
            child: IconButton(icon: Icon(Icons.chevron_left), onPressed: () {}),
          ),
        ),
        Expanded(
          flex: 6,
          child: GestureDetector(
            onTap: () {
              isOpen = !isOpen;
              setState(() {});
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '$year.$month',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                  ),
                ),
                Icon(isOpen
                    ? Icons.keyboard_arrow_down
                    : Icons.keyboard_arrow_up)
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.center,
            child:
                IconButton(icon: Icon(Icons.chevron_right), onPressed: () {}),
          ),
        ),
      ],
    );
  }

  /*
  * 显示周的组件，使用了 _weekTitleItem
  * */
  _weekItem(double screenW) {
    List<String> _listS = <String>[
      '日',
      '一',
      '二',
      '三',
      '四',
      '五',
      '六',
    ];
    List<Widget> _listW = [];
    _listS.forEach((title) {
      _listW.add(_weekTitleItem(title, (screenW - 40) / 7));
    });

    return Container(
      width: screenW - 40,
      height: 17,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _listW,
      ),
    );
  }

  /*
  * 周内对应的每天的组件
  * */
  _weekTitleItem(String title, double width) {
    return Container(
      alignment: Alignment.center,
      width: width,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.deepOrangeAccent,
          fontSize: 12,
          fontFamily: 'PingFangSC-Semibold',
        ),
      ),
    );
  }

  List<Row> allListRow = [];
  List<Row> allLineRow = [];

  _monthAllDays(int year, int month, BuildContext context) {
    double screenWith = MediaQuery.of(context).size.width;

    // 当前月前面空的天数
    int emptyDays = TimeUtil.numberOfHeadPlaceholderForMonth(
        year, month, MaterialLocalizations.of(context));

    List<Widget> _list = <Widget>[];

    for (int i = 1; i <= emptyDays; i++) {
      _list.add(_dayEmptyTitleItem(context));
    }

    for (int i = 1; i <= _listModel.length; i++) {
      _list.add(_dayTitleItem(_listModel[i - 1], context));
    }
    allListRow.clear();
    allListRow = <Row>[
      Row(
        children: _list.sublist(0, 7),
      ),
      Row(
        children: _list.sublist(7, 14),
      ),
      Row(
        children: _list.sublist(14, 21),
      ),
    ];

    if (_rows == 4) {
      allListRow.add(
        Row(
          children: _list.sublist(21, _list.length),
        ),
      );
    } else if (_rows == 5) {
      allListRow.add(
        Row(
          children: _list.sublist(21, 28),
        ),
      );
      allListRow.add(
        Row(
          children: _list.sublist(28, _list.length),
        ),
      );
    } else if (_rows == 6) {
      allListRow.add(
        Row(
          children: _list.sublist(21, 28),
        ),
      );
      allListRow.add(
        Row(
          children: _list.sublist(28, 25),
        ),
      );
      allListRow.add(
        Row(
          children: _list.sublist(35, _list.length),
        ),
      );
    }
    allLineRow.clear();
    if (widget.currentDay >= 0 && widget.currentDay < 7) {
      allLineRow.add(allListRow[0]);
    } else if (widget.currentDay >= 7 && widget.currentDay < 14) {
      allLineRow.add(allListRow[1]);
    } else if (widget.currentDay >= 14 && widget.currentDay < 21) {
      allLineRow.add(allListRow[2]);
    } else if (widget.currentDay >= 21) {
      allLineRow.add(allListRow[3]);
    }

    return Container(
      width: screenWith - 40,
      color: Colors.white,
      height: 52.0 * _rows,
      child: Column(
        children: isOpen ? allListRow : allLineRow,
      ),
    );
  }

  /*
  * number 月的几号
  * isOverdue 是否过期
  * */
  _dayTitleItem(DayModel model, BuildContext context) {
    double screenWith = MediaQuery.of(context).size.width;
    double singleW = (screenWith - 40) / 7;
    String dayTitle = model.day;
    if (widget.itemModel.firstSelectModel != null &&
        model.isSelect &&
        model.dayNum == widget.itemModel.firstSelectModel.dayNum) {
      dayTitle = '入住';
    }
    if (widget.itemModel.lastSelectModel != null &&
        model.isSelect &&
        model.dayNum == widget.itemModel.lastSelectModel.dayNum) {
      dayTitle = '离开';
    }
    return GestureDetector(
      onTap: () {
        if (model.isOverdue) return;
        _dayTitleItemTap(model);
      },
      child: Stack(
        children: <Widget>[
          Container(
            width: singleW,
            height: 52,
            alignment: Alignment.center,
            child: Text(
              dayTitle,
              style: TextStyle(
                color: model.isOverdue ? Colors.red : Colors.green,
                fontSize: 15,
                fontFamily: 'Avenir-Medium',
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Visibility(
                visible: model.isOverdue ? false : model.isSelect,
                child:
                    Container(height: 4, width: singleW, color: Colors.yellow)),
          ),
        ],
      ),
    );
  }

  _dayEmptyTitleItem(BuildContext context) {
    double screenWith = MediaQuery.of(context).size.width;
    double singleW = (screenWith - 40) / 7;
    return Container(
      width: singleW,
      height: 52,
    );
  }

  _dayTitleItemTap(DayModel model) {
    widget.dayItemOnTap(
        widget.itemModel.year, widget.itemModel.month, model.dayNum);
    setState(() {});
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_futrue_example/page/bat_page/bar_page4.dart';
import 'package:flutter_futrue_example/page/bat_page/bar_page5.dart';
import 'package:flutter_futrue_example/page/bat_page/bar_page6.dart';

class TabBarHomePage2 extends StatefulWidget {
  const TabBarHomePage2({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new TabBarHomePage2State();
  }
}

class TabBarHomePage2State extends State<TabBarHomePage2>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  String hasBeenApproved;
  String hotApproved;

  List<Tab> myTabs = [];

  void initTabs() {
    myTabs.clear();
    myTabs.add(
      Tab(text: '福利 '),
    );
    myTabs.add(
      Tab(text: '新闻'),
    );
    myTabs.add(
      Tab(text: '政要'),
    );
  }

  @override
  void initState() {
    initTabs();
    _tabController = new TabController(
      vsync: this,
      length: 3,
      initialIndex: 1,
    );

    super.initState();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('每次滑动都会触发刷新'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
//            RouteHelper.pushWidget(
//                context, new OtherPage1(), replaceRoot: false);
            },
          ),
        ],
      ),
      body: DefaultTabController(
        length: myTabs.length,
        child: new Column(
          children: <Widget>[
            new Material(
              color: Theme.of(context).primaryColor,
              child: SizedBox(
                height: 48.0,
                width: double.infinity,
                child: new TabBar(
                  controller: _tabController,
                  tabs: myTabs, //使用Tab类型的数组呈现Tab标签
                  indicatorColor: Colors.white,
                  isScrollable: false,
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  new BarPage4(),
                  new BarPage5(),
                  new BarPage6()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

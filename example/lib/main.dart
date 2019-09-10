import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_futrue_example/home.dart';
import 'package:flutter_futrue_example/net/net.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HttpManager().initDio(yourIntercept: null, yourPEM: '9527');
    return MaterialApp(
      title: 'AllRoundRefresh  Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

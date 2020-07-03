import 'package:flutter/material.dart';
import 'package:groceryman/Drawer/MainHome.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MainHome(),
    );
  }
}

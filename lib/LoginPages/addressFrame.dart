import 'dart:ui';

import 'package:groceryman/LoginPages/address.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddressFrame extends StatefulWidget {
  final String phno;
  AddressFrame({Key key, this.phno}) : super(key: key);

  @override
  _AddressFrameState createState() => _AddressFrameState();
}

class _AddressFrameState extends State<AddressFrame> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF900c3f),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Enter Primary Address',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 40.0,
                        fontFamily: 'sf_pro'),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  height: 360,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: PageView(
                      controller: pageController,
                      children: <Widget>[
                        Address(
                          phno: widget.phno,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

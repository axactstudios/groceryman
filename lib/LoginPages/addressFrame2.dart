import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:groceryman/Classes/User.dart';
import 'package:flutter/material.dart';

import 'address2.dart';

// ignore: must_be_immutable
class AddressFrame2 extends StatefulWidget {
  User userData = User();
  AddressFrame2({Key key, this.userData}) : super(key: key);

  @override
  _AddressFrame2State createState() => _AddressFrame2State();
}

class _AddressFrame2State extends State<AddressFrame2> {
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                SafeArea(
                  child: Padding(
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
                ),
                SizedBox(
                  height: 35,
                ),
                Center(
                  child: Container(
                    height: 360,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: PageView(
                        controller: pageController,
                        children: <Widget>[
                          Center(
                            child: Address2(
                              userData: widget.userData,
                            ),
                          )
                        ],
                      ),
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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../Drawer/MainHome.dart';
import '../LoginPages/addressFrame.dart';
import '../LoginPages/addressFrame.dart';

class SignedIn extends StatefulWidget {
  String phNo;

  SignedIn({this.phNo});

  @override
  _SignedInState createState() => _SignedInState();
}

class _SignedInState extends State<SignedIn> {
  getDatabaseRef() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DatabaseReference useraddressref = FirebaseDatabase
        .instance //Used the UID of the user to check if record exists in the database or not
        .reference()
        .child('Users')
        .child(user.uid);
    useraddressref.once().then((DataSnapshot snap) {
      // ignore: non_constant_identifier_names
      var DATA = snap.value;
      if (DATA == null) {
        setState(() {
          isStored = false;
        });
      } else {
        setState(() {
          isStored = true;
        });
      }
    });
  }

  bool isStored = false;

  @override
  void initState() {
    getDatabaseRef();
    new Future.delayed(Duration(seconds: 3), () {
      if (isStored) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainHome()),
        );
      } else {
        print(widget.phNo);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => AddressFrame(
                    phno: widget.phNo,
                  )),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF900c3f),
      body: Center(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'images/signed in.png',
                  height: 150,
                  width: 150,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Signed In',
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontFamily: 'sf_pro'),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Redirecting...',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontFamily: 'sf_pro'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

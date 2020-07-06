import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groceryman/Classes/User.dart';
import 'package:groceryman/Drawer/MainHome.dart';
import 'package:groceryman/OtherPages/ProfilePage.dart';

class Address2 extends StatefulWidget {
  User userData = User();
  Address2({Key key, this.userData}) : super(key: key);
  @override
  _Address2State createState() => _Address2State();
}

class _Address2State extends State<Address2> {
  FirebaseAuth mAuth = FirebaseAuth.instance;

  TextEditingController myController = TextEditingController();
  TextEditingController myController1 = TextEditingController();
  TextEditingController myController2 = TextEditingController();
  TextEditingController myController3 = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    myController.dispose();

    super.dispose();
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  FirebaseUser user;
  @override
  void initState() {
    super.initState();
    myController = TextEditingController(text: "${widget.userData.name}");
    myController1 = TextEditingController(text: "${widget.userData.add1}");
    myController2 = TextEditingController(text: "${widget.userData.add2}");
    myController3 = TextEditingController(text: "${widget.userData.pin}");

    getCurrentUser();
  }

  void getCurrentUser() async {
    FirebaseUser _user = await _firebaseAuth.currentUser();
    setState(() {
      user = _user;
    });
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextFormField(
              controller: myController,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                hintText: 'Full Name',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
              validator: (name) {
                if (name.isEmpty) {
                  return 'This field cannot be blank';
                } else
                  return null;
              },
              style: TextStyle(color: Colors.white, fontSize: 24.0),
            ),
            TextFormField(
              controller: myController1,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                hintText: 'Address Line 1',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
              validator: (line1) {
                if (line1.isEmpty) {
                  return 'This field cannot be blank';
                } else
                  return null;
              },
              style: TextStyle(color: Colors.white, fontSize: 24.0),
            ),
            TextFormField(
              controller: myController2,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                hintText: 'Address Line 2',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
              validator: (line2) {
                if (line2.isEmpty) {
                  return 'This field cannot be blank';
                } else
                  return null;
              },
              style: TextStyle(color: Colors.white, fontSize: 24.0),
            ),
            TextFormField(
              controller: myController3,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                hintText: 'Pincode',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
              validator: (pincode) {
                if (pincode.isEmpty) {
                  return 'This field cannot be blank';
                } else
                  return null;
              },
              style: TextStyle(color: Colors.white, fontSize: 24.0),
            ),
            InkWell(
              onTap: () async {
                FirebaseUser user = await mAuth.currentUser();

                if (formKey.currentState.validate()) {
                  print(widget.userData.phNo);
                  DatabaseReference dbRef =
                      FirebaseDatabase.instance.reference();
                  dbRef.child('Users').child(user.uid).set({
                    "Name": myController.text,
                    "Add1": myController1.text,
                    'Add2': myController2.text,
                    'Zip': myController3.text,
                    'phNo': widget.userData.phNo
                  });
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 34.0),
                decoration: BoxDecoration(
                    color: Color(0xFFfc9d9d),
                    borderRadius: BorderRadius.circular(15.0)),
                child: Text(
                  'SAVE',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

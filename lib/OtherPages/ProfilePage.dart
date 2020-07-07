import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:groceryman/Classes/User.dart';
import 'package:groceryman/LoginPages/addressFrame2.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User userData = User();
  DatabaseReference dbRef = FirebaseDatabase.instance.reference();
  FirebaseAuth mAuth = FirebaseAuth.instance;

  getUserData() async {
    FirebaseUser user = await mAuth.currentUser();
    String uid = user.uid;

    DatabaseReference userRef = dbRef.child('Users').child(uid);
    userRef.once().then((DataSnapshot snapshot) async {
      userData.name = await snapshot.value['Name'];
      print(userData.name);
      userData.phNo = await snapshot.value['phNo'];
      print(userData.phNo);
      userData.add1 = await snapshot.value['Add1'];
      print(userData.add1);
      userData.add2 = await snapshot.value['Add2'];
      print(userData.add2);
      userData.pin = await snapshot.value['Zip'];
      print(userData.pin);
      setState(() {
        print('Done');
      });
    });
  }

  @override
  void initState() {
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF900c3f),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddressFrame2(
                            userData: userData,
                          )),
                );
              },
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: SafeArea(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2629,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFF900c3f),
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(75)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 150,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Text(
                            'PROFILE',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 25,
                                fontFamily: 'sf_pro',
                                letterSpacing: 5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.14,
                  ),
                  userData.name == null
                      ? SpinKitWave(
                          color: Color(0xFF900c3f),
                        )
                      : Container(
                          height: size.height * 0.5,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xFF900c3f),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(75),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: size.width * 0.75,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.person,
                                            color: Color(0xFF900c3f),
                                            size: 30,
                                          ),
                                          SizedBox(
                                            width: size.width * 0.1,
                                          ),
                                          Container(
                                            width: size.width * 0.5,
                                            child: Text(
                                              userData.name,
                                              style: TextStyle(
                                                  color: Color(0xFF900c3f),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'sf_pro'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: size.width * 0.75,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.phone,
                                            color: Color(0xFF900c3f),
                                            size: 30,
                                          ),
                                          SizedBox(
                                            width: size.width * 0.1,
                                          ),
                                          Container(
                                            width: size.width * 0.5,
                                            child: Text(
                                              userData.phNo,
                                              style: TextStyle(
                                                  color: Color(0xFF900c3f),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'sf_pro'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: size.width * 0.75,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.home,
                                            color: Color(0xFF900c3f),
                                            size: 30,
                                          ),
                                          SizedBox(
                                            width: size.width * 0.1,
                                          ),
                                          Container(
                                            width: size.width * 0.5,
                                            child: Text(
                                              userData.add1,
                                              style: TextStyle(
                                                  color: Color(0xFF900c3f),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'sf_pro'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: size.width * 0.75,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.location_city,
                                            color: Color(0xFF900c3f),
                                            size: 30,
                                          ),
                                          SizedBox(
                                            width: size.width * 0.1,
                                          ),
                                          Container(
                                            width: size.width * 0.5,
                                            child: Text(
                                              userData.add2,
                                              style: TextStyle(
                                                  color: Color(0xFF900c3f),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'sf_pro'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: size.width * 0.75,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.location_on,
                                            color: Color(0xFF900c3f),
                                            size: 30,
                                          ),
                                          SizedBox(
                                            width: size.width * 0.1,
                                          ),
                                          Container(
                                            width: size.width * 0.5,
                                            child: Text(
                                              userData.pin,
                                              style: TextStyle(
                                                  color: Color(0xFF900c3f),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'sf_pro'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

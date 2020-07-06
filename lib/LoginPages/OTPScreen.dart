import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:groceryman/LoginPages/addressFrame.dart';
import 'package:groceryman/OtherPages/SignedIn.dart';

import '../Drawer/MainHome.dart';
import 'OTPinput.dart';

class OTPScreen extends StatefulWidget {
  final String mobileNumber;
  OTPScreen({
    Key key,
    @required this.mobileNumber,
  })  : assert(mobileNumber != null),
        super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Control the input text field.
  TextEditingController _pinEditingController = TextEditingController();

  /// Decorate the outside of the Pin.
  PinDecoration _pinDecoration =
      UnderlineDecoration(enteredColor: Colors.black, hintText: '333333');

  bool isCodeSent = false;
  String _verificationId;

  @override
  void initState() {
    super.initState();
    _onVerifyCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF900c3f),
      appBar: AppBar(
          backgroundColor: Color(0xFF900c3f),
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 16.0, bottom: 16, top: 4),
              color: Color(0xFF900c3f),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Image.asset(
                    'images/fruits.png',
                    scale: 2,
                  ),
                  Text(
                    "Buy Fresh Daily, Eat Fresh Daily",
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'sf_pro'),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 16, 0),
                    child: Text(
                      "OTP sent to ${widget.mobileNumber}",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'sf_pro',
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Color(0xFF900c3f),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: PinInputTextField(
                        pinLength: 6,
                        decoration: _pinDecoration,
                        controller: _pinEditingController,
                        autoFocus: true,
                        textInputAction: TextInputAction.done,
                        onSubmit: (pin) {
                          if (pin.length == 6) {
                            _onFormSubmitted();
                          } else {
                            showToast("Invalid OTP", Colors.red);
                          }
                        },
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(top: 10, left: 16, right: 16),
                      child: Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: RaisedButton(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Text(
                              "ENTER OTP",
                              style: TextStyle(
                                  color: Color(0xFF900c3f),
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              if (_pinEditingController.text.length == 6) {
                                _onFormSubmitted();
                              } else {
                                showToast("Invalid OTP", Colors.white);
                              }
                            },
                            padding: EdgeInsets.all(16.0),
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
    );
  }

  void showToast(message, Color color) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: color,
      textColor: Color(0xFF900c3f),
      fontSize: 16.0,
    );
  }

  void _onVerifyCode() async {
    setState(() {
      isCodeSent = true;
    });
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _firebaseAuth
          .signInWithCredential(phoneAuthCredential)
          .then((AuthResult value) async {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SignedIn(),
            ));
//        if (value.user != null) {
//          FirebaseUser user = await FirebaseAuth.instance.currentUser();
//          DatabaseReference useraddressref = FirebaseDatabase
//              .instance //Used the UID of the user to check if record exists in the database or not
//              .reference()
//              .child('Users')
//              .child(user.uid);
//          useraddressref.once().then((DataSnapshot snap) {
//            // ignore: non_constant_identifier_names
//            var DATA = snap.value;
//            if (DATA == null) {
//              Navigator.pushAndRemoveUntil(
//                  context,
//                  MaterialPageRoute(
//                    builder: (context) => AddressFrame(
//                      phno: widget.mobileNumber,
//                    ),
//                  ),
//                  (Route<dynamic> route) => false);
//            } else {
//              Navigator.pushAndRemoveUntil(
//                  context,
//                  MaterialPageRoute(
//                    builder: (context) => null,
//                  ),
//                  (Route<dynamic> route) => false);
//            }
//          });
//        } else {
//          showToast("Error validating OTP, try again", Colors.white);
//        }
      }).catchError((error) {
        showToast("Try again in sometime", Colors.white);
      });
    };
    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      showToast(authException.message, Colors.white);
      setState(() {
        isCodeSent = false;
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      showToast('sent', Colors.white);
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };

    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+91${widget.mobileNumber}",
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void _onFormSubmitted() async {
    AuthCredential _authCredential = PhoneAuthProvider.getCredential(
      verificationId: _verificationId,
      smsCode: _pinEditingController.text,
    );

    _firebaseAuth
        .signInWithCredential(_authCredential)
        .then((AuthResult value) async {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SignedIn(),
          ));

//      if (value.user != null) {
//        FirebaseUser user = await FirebaseAuth.instance.currentUser();
//        DatabaseReference useraddressref = FirebaseDatabase
//            .instance //Used the UID of the user to check if record exists in the database or not
//            .reference()
//            .child('Users')
//            .child(user.uid);
//        useraddressref.once().then((DataSnapshot snap) {
//          // ignore: non_constant_identifier_names
//          var DATA = snap.value;
//          if (DATA == null) {
//            Navigator.pushAndRemoveUntil(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => AddressFrame(
//                    phno: widget.mobileNumber,
//                  ),
//                ),
//                (Route<dynamic> route) => false);
//          } else {
//            Navigator.pushAndRemoveUntil(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => null,
//                ),
//                (Route<dynamic> route) => false);
//          }
//        });
//      } else {
//        showToast("Error validating OTP, try again", Colors.white);
//      }
    }).catchError((error) {
      showToast("Something went wrong", Colors.white);
    });
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/avatar/gf_avatar.dart';
import 'package:getflutter/components/drawer/gf_drawer.dart';

void signOut() async {
  await FirebaseAuth.instance.signOut();
}

Widget retNavDrawer() {
  return GFDrawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        SizedBox(
          height: 50,
          child: Container(
            color: Color(0xFF900c3f),
          ),
        ),
        Container(
          color: Color(0xFF900c3f),
          height: 150,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GFAvatar(
                  size: 65,
                  backgroundColor: Colors.white,
                  child: Text(
                    'GM',
                    style: TextStyle(
                        fontSize: 50,
                        color: Colors.black,
                        fontFamily: 'sf_pro',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Grocery Man',
                    style: TextStyle(
                        fontFamily: 'nunito',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    'support@groceryman.com',
                    style: TextStyle(
                        fontFamily: 'nunito',
                        fontSize: 12,
                        color: Color(0xFFFFE600)),
                  )
                ],
              )
            ],
          ),
        ),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Text(
              'Shop By Categories',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'nunito',
                  fontWeight: FontWeight.w600),
            ),
          ),
          onTap: null,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          height: 0.5,
          color: Colors.black26,
        ),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Text(
              'Your Orders',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'nunito',
                  fontWeight: FontWeight.w600),
            ),
          ),
          onTap: () {},
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          height: 0.5,
          color: Colors.black26,
        ),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Text(
              'Your Account',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'nunito',
                  fontWeight: FontWeight.w600),
            ),
          ),
          onTap: () {},
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          height: 0.5,
          color: Colors.black26,
        ),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Text(
              'Support',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'nunito',
                  fontWeight: FontWeight.w600),
            ),
          ),
          onTap: () {},
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          height: 0.5,
          color: Colors.black26,
        ),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Text(
              'Privacy Policy',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'nunito',
                  fontWeight: FontWeight.w600),
            ),
          ),
          onTap: () {},
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          height: 0.5,
          color: Colors.black26,
        ),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Text(
              'Log Out',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'nunito',
                  fontWeight: FontWeight.w600),
            ),
          ),
          onTap: () {
            signOut();
          },
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          height: 0.5,
          color: Colors.black26,
        ),
      ],
    ),
  );
}

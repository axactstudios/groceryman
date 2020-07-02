import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/carousel/gf_carousel.dart';

import '../navDrawer.dart';

class MainHome extends StatefulWidget {
  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  final List<String> imageList = ['fruits.png', 'market.png', 'vegetable.png'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: retNavDrawer(),
      appBar: AppBar(
        backgroundColor: Color(0xFF900c3f),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GFCarousel(
          items: imageList.map(
            (url) {
              return Card(
                elevation: 8,
                margin: EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Image.asset('images/$url',
                      fit: BoxFit.cover, width: 1000.0),
                ),
              );
            },
          ).toList(),
          onPageChanged: (index) {
            setState(() {
              index;
            });
          },
          autoPlay: true,
          enlargeMainPage: true,
          pagination: true,
          passiveIndicator: Colors.black,
          activeIndicator: Colors.white,
          pagerSize: 10,
        ),
      ),
    );
  }
}

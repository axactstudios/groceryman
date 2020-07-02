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
        title: Text(
          'Grocery Man',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontFamily: 'sf_pro'),
        ),
        backgroundColor: Color(0xFF900c3f),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GFCarousel(
              items: imageList.map(
                (url) {
                  return Card(
                    elevation: 8,
                    margin: EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: Image.asset('images/$url',
                            fit: BoxFit.cover, width: 1000.0),
                      ),
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
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Container(
                height: 400,
                child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 3,
                  childAspectRatio: 0.7,
                  children: <Widget>[
                    categoryCard('Fruits', 'bananas.png'),
                    categoryCard('Dairy', 'milk.png'),
                    categoryCard('Vegetables', 'vegetable1.png'),
                    categoryCard('Snacks', 'snacks.png'),
                    categoryCard('Provisions', 'flour.png'),
                    categoryCard('Meat', 'meat.png'),
                    categoryCard('Bakery', 'bread.png'),
                    categoryCard('Garden', 'plant.png'),
                    categoryCard('Food', 'cutlery.png'),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget categoryCard(name, image) {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          Image.asset('images/$image'),
          SizedBox(
            height: 10,
          ),
          Text(
            name,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

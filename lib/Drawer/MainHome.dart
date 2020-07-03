import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/carousel/gf_carousel.dart';
import 'package:groceryman/Classes/ItemsClass.dart';
import 'package:groceryman/OtherPages/CartPage.dart';

import '../OtherPages/itemPage.dart';
import 'navDrawer.dart';

class MainHome extends StatefulWidget {
  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  final List<String> imageList = ['fruits.png', 'market.png', 'vegetable.png'];
  // ignore: non_constant_identifier_names
  final List<Items> Fruits = [];
  // ignore: non_constant_identifier_names
  final List<Items> Vegetables = [];
  // ignore: non_constant_identifier_names
  final List<Items> Dairy = [];
  // ignore: non_constant_identifier_names
  final List<Items> Food = [];
  // ignore: non_constant_identifier_names
  final List<Items> Bakery = [];
  // ignore: non_constant_identifier_names
  final List<Items> Meat = [];
  // ignore: non_constant_identifier_names
  final List<Items> Provisions = [];
  // ignore: non_constant_identifier_names
  final List<Items> Snacks = [];
  // ignore: non_constant_identifier_names
  final List<Items> Garden = [];

  void getItemsRef(List items, String category) {
    DatabaseReference itemsref =
        FirebaseDatabase.instance.reference().child(category);
    itemsref.once().then((DataSnapshot snap) {
      // ignore: non_constant_identifier_names
      var KEYS = snap.value.keys;
      // ignore: non_constant_identifier_names
      var DATA = snap.value;
      items.clear();
      for (var key in KEYS) {
        Items c = new Items(
          DATA[key]['Name'],
          DATA[key]['ImageUrl'],
          DATA[key]['Price'],
          DATA[key]['Quantity'],
        );
        items.add(c);
      }
      setState(() {
        print(items.length);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getItemsRef(Fruits, 'Fruits');
    getItemsRef(Vegetables, 'Vegetables');
    getItemsRef(Snacks, 'Snacks');
    getItemsRef(Food, 'Food');
    getItemsRef(Dairy, 'Dairy');
    getItemsRef(Meat, 'Meat');
    getItemsRef(Provisions, 'Provisions');
    getItemsRef(Garden, 'Garden');
    getItemsRef(Bakery, 'Bakery');
  }

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
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
                );
              },
              child: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
          ),
        ],
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
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 3,
                  childAspectRatio: 0.7,
                  children: <Widget>[
                    categoryCard('Fruits', 'bananas.png', Fruits),
                    categoryCard('Dairy', 'milk.png', Dairy),
                    categoryCard('Vegetables', 'vegetable1.png', Vegetables),
                    categoryCard('Snacks', 'snacks.png', Snacks),
                    categoryCard('Provisions', 'flour.png', Provisions),
                    categoryCard('Meat', 'meat.png', Meat),
                    categoryCard('Bakery', 'bread.png', Bakery),
                    categoryCard('Garden', 'plant.png', Garden),
                    categoryCard('Food', 'cutlery.png', Food),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget categoryCard(name, image, List name1) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Item(name1)),
        );
      },
      child: Card(
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
      ),
    );
  }
}

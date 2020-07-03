import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:groceryman/Classes/Cart.dart';
import 'package:groceryman/Classes/DatabaseHelper.dart';
import 'package:groceryman/OtherPages/CartPage.dart';

// ignore: must_be_immutable
class Item extends StatefulWidget {
  List itemCategory;
  Item(this.itemCategory);
  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: widget.itemCategory.length == 0
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              itemCount: widget.itemCategory.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (_, index) {
                return UI(
                  widget.itemCategory[index].name,
                  widget.itemCategory[index].imageUrl,
                  widget.itemCategory[index].price,
                );
              },
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 10.0),
            ),
    );
  }

  Widget UI(name, imageUrl, price) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          child: Column(
            children: [
              Image.network(
                price,
                height: 100,
                width: 100,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "₹$imageUrl",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                name,
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  addToCart(name: name, imgUrl: imageUrl, price: price, qty: 1);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF900c3f),
                    borderRadius: BorderRadius.circular(33),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      'Add to cart',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addToCart({String name, String imgUrl, String price, int qty}) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnProductName: name,
      DatabaseHelper.columnImageUrl: imgUrl,
      DatabaseHelper.columnPrice: price,
      DatabaseHelper.columnQuantity: qty
    };
    Cart item = Cart.fromMap(row);
    final id = await dbHelper.insert(item);
    Fluttertoast.showToast(
        msg: 'inserted row id: $id', toastLength: Toast.LENGTH_SHORT);
  }
}

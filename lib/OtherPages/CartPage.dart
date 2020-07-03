import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:groceryman/Classes/Cart.dart';
import 'package:groceryman/Classes/DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Cart> cartItems = [];
  final dbHelper = DatabaseHelper.instance;

  int newQty;

  void getAllItems() async {
    final allRows = await dbHelper.queryAllRows();
    cartItems.clear();
    allRows.forEach((row) => cartItems.add(Cart.fromMap(row)));
    print(cartItems[0].imgUrl);

    setState(() {});
  }

  void updateItem(
      {int id, String name, String imgUrl, String price, int qty}) async {
    // row to update
    Cart item = Cart(id, name, imgUrl, price, qty);
    final rowsAffected = await dbHelper.update(item);
    Fluttertoast.showToast(msg: 'Updated', toastLength: Toast.LENGTH_SHORT);
    getAllItems();
  }

  void removeItem(String name) async {
    // Assuming that the number of rows is the id for the last row.
    final rowsDeleted = await dbHelper.delete(name);
    getAllItems();
  }

  @override
  void initState() {
    getAllItems();
  }

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
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    var item = cartItems[index];
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFF900c3f),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Image.network(
                                item.price,
                                height: 70,
                                width: 70,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    item.productName,
                                    style: TextStyle(
                                        fontFamily: 'sf_pro',
                                        color: Colors.white,
                                        fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Price : ${item.imgUrl}',
                                    style: TextStyle(
                                        fontFamily: 'sf_pro',
                                        color: Colors.white,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Qty:',
                                        style: TextStyle(
                                            fontFamily: 'sf_pro',
                                            color: Colors.white,
                                            fontSize: 14),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (item.qty == 1) {
                                            removeItem(item.productName);
                                          } else {
                                            newQty = item.qty - 1;
                                            updateItem(
                                                id: item.id,
                                                name: item.productName,
                                                imgUrl: item.imgUrl,
                                                price: item.price,
                                                qty: newQty);
                                          }
                                        },
                                        child: Icon(
                                          Icons.indeterminate_check_box,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Container(
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            item.qty.toString(),
                                            style: TextStyle(
                                                fontFamily: 'sf_pro',
                                                color: Colors.black,
                                                fontSize: 17),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      newQty = item.qty + 1;
                                      updateItem(
                                          id: item.id,
                                          name: item.productName,
                                          imgUrl: item.imgUrl,
                                          price: item.price,
                                          qty: newQty);
                                    },
                                    child: Icon(
                                      Icons.add_box,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      removeItem(item.productName);
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

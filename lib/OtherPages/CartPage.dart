import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:groceryman/Classes/Cart.dart';
import 'package:groceryman/Classes/DatabaseHelper.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:intl/intl.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Cart> cartItems = [];
  final dbHelper = DatabaseHelper.instance;
  final dbRef = FirebaseDatabase.instance.reference();
  FirebaseAuth mAuth = FirebaseAuth.instance;
  Razorpay _razorpay;

  int newQty;

  void getAllItems() async {
    final allRows = await dbHelper.queryAllRows();
    cartItems.clear();
    allRows.forEach((row) => cartItems.add(Cart.fromMap(row)));
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
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    double pWidth = MediaQuery.of(context).size.width;
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
                            children: <Widget>[
                              Container(
                                width: pWidth * 0.2,
                                child: Image.network(
                                  item.price,
                                  height: 70,
                                  width: 70,
                                ),
                              ),
                              Container(
                                width: pWidth * 0.4,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                ),
                              ),
                              Container(
                                width: pWidth * 0.3,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
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
                                        size: pWidth * 0.07,
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4),
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
                                        size: pWidth * 0.07,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        removeItem(item.productName);
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                        size: pWidth * 0.07,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 4,
              decoration: BoxDecoration(
                color: Color(0xFF900c3f),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          width: pWidth * 0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              FittedBox(
                                child: Text(
                                  "Order Total = Rs. ${(totalAmount() + (0.18 * totalAmount()) + 40).toStringAsFixed(2)}  ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'sf_pro',
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              40),
                                ),
                              ),
                              FittedBox(
                                child: Text(
                                  "Products Total = Rs. ${totalAmount()}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'sf_pro',
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              60),
                                ),
                              ),
                              FittedBox(
                                child: Text(
                                  "GST(18%) = Rs. ${(totalAmount() * 0.18).toStringAsFixed(2)}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'sf_pro',
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              60),
                                ),
                              ),
                              FittedBox(
                                child: Text(
                                  "Delivery Charges = Rs. 40.0",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'sf_pro',
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              60),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                onOrderPlaced();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  color: Colors.white,
                                ),
                                width:
                                    MediaQuery.of(context).size.width * 0.315,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Text(
                                    "Proceed for COD",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'sf_pro',
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                50,
                                        color: Color(0xFF900c3f)),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 70,
                            ),
                            InkWell(
                              onTap: () async {
                                await onOrderPlaced();
                                openCheckout();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  color: Colors.white,
                                ),
                                width:
                                    MediaQuery.of(context).size.width * 0.315,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 7),
                                  child: Center(
                                    child: Text(
                                      "Pay online",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'sf_pro',
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              45,
                                          color: Color(0xFF900c3f)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: MediaQuery.of(context).size.height - 20,
                        height: MediaQuery.of(context).size.height / 18,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Text(
                              "Check address details",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'sf_pro',
                                  fontSize:
                                      MediaQuery.of(context).size.height / 60,
                                  color: Color(0xFF900c3f)),
                            ),
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

  Future<void> onOrderPlaced() async {
    List<String> item = [];
    List<int> qty = [];
    double orderAmount = totalAmount();

    for (int i = 0; i < cartItems.length; i++) {
      item.add(cartItems[i].productName);
      qty.add(cartItems[i].qty);
    }

    FirebaseUser user = await mAuth.currentUser();

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy  kk:mm').format(now);

    dbRef
        .child('Orders')
        .child(user.uid)
        .child(TimeOfDay.now().toString())
        .set({
      "itemsName": item,
      "itemsQty": qty,
      'orderAmount': orderAmount,
      'isCompleted': false,
      'DateTime': formattedDate,
      'CompletedTime': 'Not yet completed',
      'ShippedTime': 'Not yet shipped',
      'Status': 'Placed',
      'orderLength': item.length
    });

    print('Order Placed');
    Navigator.pop(context);
  }

  double totalAmount() {
    double sum = 0;
    getAllItems();
    for (int i = 0; i < cartItems.length; i++) {
      sum += (double.parse(cartItems[i].imgUrl) * cartItems[i].qty);
    }
    return sum;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void openCheckout() async {
    var options = {
      'key': 'abc',
      'amount': ((totalAmount() + 0.18 * totalAmount() + 40) * 100).toString(),
      'name': 'Axact Studios',
      'description': 'Bill',
      'prefill': {'contact': '', '': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, timeInSecForIosWeb: 4);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIosWeb: 4);
  }
}

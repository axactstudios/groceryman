import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:groceryman/Classes/Orders.dart';

class OrdersPage extends StatefulWidget {
  List<Orders> pastOrders = [];
  List<Orders> ongoingOrders = [];

  OrdersPage({this.ongoingOrders, this.pastOrders});

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Your Orders',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
                fontFamily: 'sf_pro'),
          ),
          backgroundColor: Color(0xFF900c3f),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.watch_later,
                  color: Colors.white,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.check_circle,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          physics: ScrollPhysics(),
          children: <Widget>[
            widget.ongoingOrders.length == 0
                ? SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: Text('You have no ongoing orders'),
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: widget.ongoingOrders.length,
                              itemBuilder: (context, index) {
                                var item = widget.ongoingOrders[index];
                                return Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF900c3f),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            'Order ${index + 1}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                fontFamily: 'sf_pro'),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                'Item Name',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18,
                                                    fontFamily: 'sf_pro'),
                                              ),
                                              Text(
                                                'Quantity',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18,
                                                    fontFamily: 'sf_pro'),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: item.itemsName.length,
                                              itemBuilder: (context, index) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                      item.itemsName[index],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16,
                                                          fontFamily: 'sf_pro'),
                                                    ),
                                                    Text(
                                                      item.itemsQty[index]
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16,
                                                          fontFamily: 'sf_pro'),
                                                    )
                                                  ],
                                                );
                                              }),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                'Order Amount',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18,
                                                    fontFamily: 'sf_pro'),
                                              ),
                                              Text(
                                                'Rs. ${item.orderAmount.toString()}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16,
                                                    fontFamily: 'sf_pro'),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
            widget.pastOrders.length == 0
                ? SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: Text('You have no completed orders'),
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: widget.pastOrders.length,
                              itemBuilder: (context, index) {
                                var item = widget.pastOrders[index];
                                return Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF900c3f),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            'Order ${index + 1}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                fontFamily: 'sf_pro'),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                'Item Name',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18,
                                                    fontFamily: 'sf_pro'),
                                              ),
                                              Text(
                                                'Quantity',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18,
                                                    fontFamily: 'sf_pro'),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: item.itemsName.length,
                                              itemBuilder: (context, index) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                      item.itemsName[index],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16,
                                                          fontFamily: 'sf_pro'),
                                                    ),
                                                    Text(
                                                      item.itemsQty[index]
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16,
                                                          fontFamily: 'sf_pro'),
                                                    )
                                                  ],
                                                );
                                              }),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                'Order Amount',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18,
                                                    fontFamily: 'sf_pro'),
                                              ),
                                              Text(
                                                'Rs. ${item.orderAmount.toString()}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16,
                                                    fontFamily: 'sf_pro'),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

//class OngoingOrders extends StatefulWidget {
//  @override
//  _OngoingOrdersState createState() => _OngoingOrdersState();
//}
//
//class _OngoingOrdersState extends State<OngoingOrders> {
//  @override
//  Widget build(BuildContext context) {
//    widget.ongoingOrders.length == 0
//        ? Container(
//            child: Center(
//              child: Text('You have no ongoing orders'),
//            ),
//          )
//        : Column(
//            children: <Widget>[
//              ListView.builder(
//                  itemCount: widget.ongoingOrders.length,
//                  itemBuilder: (context, index) {
//                    var item = widget.ongoingOrders[index];
//                    return Container(
//                      decoration: BoxDecoration(
//                        color: Color(0xFF900c3f),
//                        borderRadius: BorderRadius.circular(15),
//                      ),
//                      child: Column(
//                        children: <Widget>[
//                          Text(
//                            'Order ${index + 1}',
//                            style: TextStyle(
//                                color: Colors.white,
//                                fontWeight: FontWeight.bold,
//                                fontSize: 18,
//                                fontFamily: 'sf_pro'),
//                          ),
//                        ],
//                      ),
//                    );
//                  }),
//            ],
//          );
//  }
//}

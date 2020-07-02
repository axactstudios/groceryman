import 'package:flutter/material.dart';

class Item extends StatefulWidget {
  List itemCategory;
  Item(this.itemCategory);
  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
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
      child: Column(
        children: [
          Image.network(
            price,
            scale: 5,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "₹$imageUrl",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            name,
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}

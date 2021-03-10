import 'package:flutter/material.dart';
import 'navigation.dart';

class DB_Products extends StatefulWidget {
  @override
  _DB_ProductsState createState() => _DB_ProductsState();
}

class _DB_ProductsState extends State<DB_Products> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (Container()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Navigation();
          }));
        },
        tooltip: 'Add Product',
        child: Icon(Icons.add),
      ),
    );
  }
}

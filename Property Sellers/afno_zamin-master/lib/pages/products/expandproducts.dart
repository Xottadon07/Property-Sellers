import 'package:dale_the_property_sellers/pages/products/recent_products.dart';
import 'package:flutter/material.dart';

import '../Custom_appbar.dart';
import '../drawer.dart';

class ExpandProd extends StatelessWidget {
  const ExpandProd({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Property Sellers',
          style: TextStyle(color: Colors.white),
        ),
        // backgroundColor: Colors.white60,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Container(
            child: Column(
              children: [
                SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(height: 700, child: RecentProducts())),
                // RecentProducts(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

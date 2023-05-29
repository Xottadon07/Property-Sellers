import 'package:dale_the_property_sellers/controllers/products_controller.dart';
import 'package:dale_the_property_sellers/model/user.dart';
import 'package:dale_the_property_sellers/pages/constants.dart';
import 'package:dale_the_property_sellers/pages/ename.dart';
import 'package:dale_the_property_sellers/pages/IndividualPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/product.dart';
import '../BottomBar.dart';
import '../category/property_tile.dart';

class PropScreen extends StatefulWidget {
  @override
  State<PropScreen> createState() => _PropScreenState();
}

class _PropScreenState extends State<PropScreen> {
  String dropdownvalue = 'Sort By';

  List<Product> allProducts = [];

  // List of items in our dropdown menu
  var items = [
    'Sort By',
    'Price (Ascending)',
    'Price (Descending)',
  ];

  @override
  void initState() {
    super.initState();

    setState(() {
      allProducts = Provider.of<ProductController>(context, listen: false).all;
    });
  }

  void sort() {
    if (dropdownvalue == 'Price (Ascending)') {
      allProducts.sort(((a, b) => a.price.compareTo(b.price)));
    } else if (dropdownvalue == 'Price (Descending)') {
      allProducts.sort(((a, b) => b.price.compareTo(a.price)));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Properties list'),
        ),
        body: Column(children: [
          Container(
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: primarycolor,
              ),
            ),
            height: 50.0,
            width: 250.0,
            child: DropdownButton(
              // Initial Value
              isExpanded: true,
              value: dropdownvalue,
              style: TextStyle(
                color: primarycolor,
                fontSize: 16,
              ),

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    dropdownvalue = newValue;
                  });
                  sort();
                }
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView(
              children:
                  allProducts.map((e) => PropertyTile(product: e)).toList(),
            ),
          )
        ]));
  }
}

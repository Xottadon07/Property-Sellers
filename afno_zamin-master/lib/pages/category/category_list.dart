import 'package:dale_the_property_sellers/controllers/products_controller.dart';
import 'package:dale_the_property_sellers/pages/constants.dart';
import 'package:dale_the_property_sellers/pages/ename.dart';
import 'package:dale_the_property_sellers/pages/IndividualPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/product.dart';
import '../BottomBar.dart';
import 'property_tile.dart';

class CategoryListScreen extends StatefulWidget {
  final String categoryName;

  CategoryListScreen({Key? key, required this.categoryName});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  String dropdownvalue = 'Sort By';

  // List of items in our dropdown menu
  var items = [
    'Sort By',
    'Default',
    'Price (up)',
    'Price (down)',
    'Latest',
    'Oldest',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${widget.categoryName} list"),
        ),
        body: Consumer<ProductController>(
            builder: (context, productController, child) {
          return Column(children: [
            Container(
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Colors.grey[100],
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
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
              ),
            ),
            Expanded(
              child: ListView(
                children: productController.all
                    .where((element) =>
                        element.category.toLowerCase() ==
                        widget.categoryName.toLowerCase())
                    .toList()
                    .map((e) => PropertyTile(product: e))
                    .toList(),
              ),
            )
          ]);
        }));
  }
}

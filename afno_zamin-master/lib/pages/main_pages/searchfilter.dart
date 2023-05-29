import 'package:dale_the_property_sellers/controllers/products_controller.dart';
import 'package:dale_the_property_sellers/model/user.dart';
import 'package:dale_the_property_sellers/pages/category/property_tile.dart';
import 'package:dale_the_property_sellers/pages/constants.dart';
import 'package:dale_the_property_sellers/pages/ename.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/product.dart';
import '../BottomBar.dart';

class Searchfilter extends StatefulWidget {
  @override
  State<Searchfilter> createState() => _SearchfilterState();
}

class _SearchfilterState extends State<Searchfilter> {
  // List of items in our dropdown menu

  List<Product> allProducts = [];
  String keyword = "";

  @override
  void initState() {
    super.initState();

    setState(() {
      allProducts = Provider.of<ProductController>(context, listen: false).all;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(4.0),
            margin: EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  keyword = value;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade300,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                //remove bar
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                hintText: 'Search ',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: allProducts
                  .where((element) => element.matches(keyword))
                  .toList()
                  .map((e) => PropertyTile(product: e))
                  .toList(),
            ),
          )
        ]),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedMenu: MenuState.search,
      ),
    );
  }
}

import 'package:dale_the_property_sellers/controllers/favorites_controller.dart';
import 'package:dale_the_property_sellers/controllers/products_controller.dart';
import 'package:dale_the_property_sellers/pages/constants.dart';
import 'package:dale_the_property_sellers/pages/ename.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../BottomBar.dart';
import '../category/property_tile.dart';

class FavScreen extends StatefulWidget {
  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ProductController, FavoriteController>(
        builder: (context, productConroller, favController, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Favorite properties'),
        ),
        body: ListView(
          children: productConroller.all
              .where((element) => favController.isFav(element))
              .toList()
              .map((e) => PropertyTile(product: e))
              .toList(),
        ),
        bottomNavigationBar: BottomNavBar(
          selectedMenu: MenuState.favorite,
        ),
      );
    });
  }
}

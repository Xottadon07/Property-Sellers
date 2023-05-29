import 'package:dale_the_property_sellers/controllers/products_controller.dart';
import 'package:dale_the_property_sellers/model/product.dart';
import 'package:dale_the_property_sellers/pages/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../favorite_button.dart';
import '../individualPage.dart';

class RecentProducts extends StatelessWidget {
  //creating product list

  @override
  Widget build(BuildContext context) {
    //creating grid to show columns of items

    return Consumer<ProductController>(
        builder: (context, productController, child) {
      return Container(
        // color: Colors.red,
        padding: const EdgeInsets.only(bottom: 32.0),
        child: GridView.builder(
            itemCount: productController.all.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.8),
            itemBuilder: (BuildContext context, int index) {
              //assign values to variables
              return RecentSingleProducts(
                  product: productController.all[index]);
            }),
      );
    });
  }
}

class RecentSingleProducts extends StatefulWidget {
  final Product product;

  RecentSingleProducts({
    Key? key,
    required this.product,
  });

  @override
  State<RecentSingleProducts> createState() => _RecentSingleProductsState();
}

class _RecentSingleProductsState extends State<RecentSingleProducts> {
  bool islike = false;
  final Color inactiveColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: (() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => IndividualPage(
                          product: widget.product,
                        )));
              }),
              child: Container(
                height: 140,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.product.image),
                  ),
                ),
              ),
            ),
            ListTile(
                title: Text(widget.product.title),
                subtitle: Text("Rs. ${widget.product.price}"),
                // we use trailing widget to create favorite
                trailing: FavoriteButton(
                  product: widget.product,
                ))
          ],
        ),
      ),
    );
  }
}

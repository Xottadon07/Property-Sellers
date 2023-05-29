import 'package:dale_the_property_sellers/controllers/favorites_controller.dart';
import 'package:dale_the_property_sellers/model/product.dart';
import 'package:dale_the_property_sellers/pages/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatefulWidget {
  final Product product;
  const FavoriteButton({Key? key, required this.product}) : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool islike = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteController>(
        builder: (context, favController, child) {
      bool islike = favController.isFav(widget.product);
      return Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            color: primarycolor, borderRadius: BorderRadius.circular(30)),
        child: IconButton(
          icon: Icon(
            islike ? Icons.favorite : Icons.favorite_border_outlined,
            color: islike ? Colors.red : Colors.white,
            size: 15,
          ),
          onPressed: () {
            if (islike) {
              favController.remove(widget.product);
            } else {
              favController.add(widget.product);
            }
          },
        ),
      );
    });
  }
}

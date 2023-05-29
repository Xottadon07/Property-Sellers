import 'dart:convert';

import 'package:dale_the_property_sellers/model/product.dart';
import 'package:dale_the_property_sellers/pages/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProductController with ChangeNotifier {
  bool isPulling = false;
  String? message;
  List<Product> all = [];

  void addNew(Product product) {
    if (all.where((element) => element.id == product.id).toList().isEmpty) {
      all.add(product);
      notifyListeners();
    }
  }

  ProductController() {
    pullAll();
  }

  void pullAll() async {
    try {
      print("Pulling all products");
      isPulling = true;
      notifyListeners();

      var resp = await http.get(Uri.parse("$kApiURL/products"));

      if (resp.statusCode != 200) {
        throw Exception("Invalid response from server.");
      }

      var parsed = jsonDecode(resp.body);

      all =
          (parsed['products'] as List).map((e) => Product.fromJson(e)).toList();
    } catch (e) {
      message = e.toString();
    } finally {
      isPulling = false;
      notifyListeners();
    }
  }
}

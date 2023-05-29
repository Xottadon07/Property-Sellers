import 'dart:convert';
import 'package:dale_the_property_sellers/pages/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<bool> like(String productId) async {
  var loggedInUserDetails =
      await FlutterSecureStorage().read(key: "ZAMIN_USER");
  if (loggedInUserDetails == null) {
    throw Exception("Login needed");
  }

  var parsed = jsonDecode(loggedInUserDetails);
  var id = parsed['_id'];
  if (id == null) throw Exception("Unable to find user id");

  var res = await http.post(Uri.parse("$kApiURL/products/like/$productId/$id"));

  if (res.statusCode == 200) return true;
  return false;
}

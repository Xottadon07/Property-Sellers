import 'dart:convert';

import 'package:dale_the_property_sellers/model/user.dart';
import 'package:dale_the_property_sellers/pages/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class UserNotifierInfo extends StatefulWidget {
  const UserNotifierInfo({Key? key, required this.userId}) : super(key: key);

  final String userId;

  @override
  State<UserNotifierInfo> createState() => _UserNotifierInfoState();
}

class _UserNotifierInfoState extends State<UserNotifierInfo> {
  User? user;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    try {
      http.Response response = await http.get(
          Uri.parse("$kApiURL/user/${widget.userId}"),
          headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200 &&
          jsonDecode(response.body.toString()) != null) {
        setState(() {
          user = User.fromJson(jsonDecode(response.body.toString()));
        });
      } else {
        Fluttertoast.showToast(
            msg: "Error occurred",
            toastLength: Toast.LENGTH_SHORT, // length
            gravity: ToastGravity.CENTER, // location
            timeInSecForIosWeb: 5);
        // message
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primarycolor,
        title: Text('User information'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10, left: 20),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Profile',
              style: TextStyle(
                  color: primarycolor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            SizedBox(
              height: 16,
            ),
            Listprofile(
                Icons.person, 'UserName', user != null ? user!.username : ''),
            Listprofile(Icons.email, 'Email', user != null ? user!.email : ''),
            Listprofile(
                Icons.phone, 'Phone', user != null ? user!.phoneNumber : ''),
          ],
        ),
      ),
    );
  }

  Widget Listprofile(IconData icon, String text1, String text2) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
          ),
          SizedBox(
            width: 24,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text1,
                style: TextStyle(color: Colors.black87, fontSize: 16),
              ),
              Text(
                text2,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}

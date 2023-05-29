import 'dart:convert';

import 'package:dale_the_property_sellers/model/user.dart';
import 'package:dale_the_property_sellers/pages/constants.dart';
import 'package:dale_the_property_sellers/pages/notificationview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Myinfo extends StatefulWidget {
  const Myinfo({Key? key}) : super(key: key);

  @override
  State<Myinfo> createState() => _MyinfoState();
}

class _MyinfoState extends State<Myinfo> {
  User? user;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    var test = await const FlutterSecureStorage().read(key: "ZAMIN_USER");
    setState(() {
      user = User.fromJson((jsonDecode(test!)));
    });
    print(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primarycolor,
        title: Text('My information'),
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
            Listprofile(Icons.person, 'UserName', user!.username),
            Listprofile(Icons.email, 'Email', user!.email),
            Listprofile(Icons.phone, 'Phone', user!.phoneNumber),
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

import 'dart:convert';

import 'package:dale_the_property_sellers/pages/drawer.dart';
import 'package:dale_the_property_sellers/pages/ename.dart';
import 'package:dale_the_property_sellers/pages/main_pages/subprofile/myinformation.dart';
import 'package:dale_the_property_sellers/pages/main_pages/subprofile/settings.dart';
import 'package:dale_the_property_sellers/pages/notificationview.dart';
import 'package:dale_the_property_sellers/pages/product/product_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import '../../model/user.dart';
import '../BottomBar.dart';
import '../Custom_appbar.dart';
import '../login_page.dart';
import 'property_list.dart';
import 'subprofile/profile_menu.dart';
import 'subprofile/profile_pic.dart';
import 'package:dale_the_property_sellers/utils/routes.dart';

class UserProfile extends StatefulWidget {
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              CustomAppBar(),
              ProfilePic(),
              SizedBox(height: 20),
              Column(
                children: [
                  Text(user?.username ?? "OM",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  Text(
                    user?.email ?? "om123@gmail.com",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              ProfileMenu(
                text: "My Property",
                icon: "assets/images/property.png",
                press: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PropScreen())),
              ),
              ProfileMenu(
                text: "My information",
                icon: "assets/images/property.png",
                press: () => Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade, child: Myinfo())),
              ),
              ProfileMenu(
                text: "Settings",
                icon: "assets/images/settings.png",
                press: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Settingspage())),
              ),
              ProfileMenu(
                  text: "Log Out",
                  icon: "assets/images/logout.png",
                  //   press: () => Navigator.push(context,
                  //       MaterialPageRoute(builder: (context) => LoginPage())),
                  // )
                  press: () => Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return LoginPage();
                      }), (r) {
                        return false;
                      })),
            ],
          ),
        ),
      ),
      drawer: drawer(),
      bottomNavigationBar: BottomNavBar(
        selectedMenu: MenuState.userprofile,
      ),
    );
  }
}

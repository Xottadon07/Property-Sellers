import 'package:flutter/material.dart';
import 'package:dale_the_property_sellers/pages/Home_screen.dart';
import 'package:dale_the_property_sellers/pages/constants.dart';
import 'package:dale_the_property_sellers/pages/login_page.dart';
import 'package:dale_the_property_sellers/pages/main_pages/property_list.dart';
import 'package:dale_the_property_sellers/pages/main_pages/user_profile.dart';
import 'package:dale_the_property_sellers/pages/signup_page.dart';

class drawer extends StatelessWidget {
  const drawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          Center(
            child: UserAccountsDrawerHeader(
              accountName: Text(""),
              accountEmail: Text(""),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/Afnoz.png',
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            iconColor: primarycolor,
            title: const Text('Home'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.account_box_rounded),
            iconColor: primarycolor,
            title: const Text('Profile'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserProfile()));
            },
          ),
          ListTile(
            leading: Icon(Icons.explore),
            iconColor: primarycolor,
            title: const Text('Explore Properties'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PropScreen()));
            },
          ),
          const Divider(
            color: primarycolor,
          ),
          // ListTile(
          //     leading: Icon(Icons.login_rounded),
          //     title: const Text('Login-IN'),
          //     iconColor: primarycolor,
          //     onTap: () {
          //       Navigator.push(context,
          //           MaterialPageRoute(builder: (context) => LoginPage()));
          //     }),
          // ListTile(
          //   leading: Icon(Icons.laptop_chromebook_rounded),
          //   title: const Text('Sign-Up'),
          //   iconColor: primarycolor,
          //   onTap: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => SignupPage()));
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.logout),
            title: const Text('Log-Out'),
            iconColor: primarycolor,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ],
      ),
    );
  }
}

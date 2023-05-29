import 'package:dale_the_property_sellers/pages/notificationview.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'constants.dart';
import 'main_pages/searchfilter.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);
  final int count = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      //space between widgets
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu, color: primarycolor),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
        Column(
          children: [
            Text(
              'Property Sellers',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        Container(
          child: Row(
            children: [
              Builder(
                builder: (context) => IconButton(
                  icon: Icon(
                    Icons.search,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Searchfilter()));
                  },
                ),
              ),
              Builder(
                builder: (context) => IconButton(
                  icon: badges.Badge(
                      badgeContent: Text('$count'),
                      badgeColor: primarycolor,
                      padding: EdgeInsets.all(3.0),
                      position: badges.BadgePosition.topStart(),
                      animationType: badges.BadgeAnimationType.slide,
                      child: Icon(
                        Icons.notifications,
                      )),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Notificaionview()));
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

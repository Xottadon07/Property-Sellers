import 'dart:convert';

import 'package:dale_the_property_sellers/pages/constants.dart';
import 'package:dale_the_property_sellers/pages/user_notifier_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Notificaionview extends StatelessWidget {
  const Notificaionview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Listview(context),
    );
  }
}

Future<List> getNotifications() async {
  var loggedInUserDetails =
      await FlutterSecureStorage().read(key: "ZAMIN_USER");
  if (loggedInUserDetails == null) {
    throw Exception("Login needed");
  }

  var parsed = jsonDecode(loggedInUserDetails);
  var id = parsed['_id'];
  if (id == null) throw Exception("Unable to find user id");

  var resp = await http.get(Uri.parse("$kApiURL/products/notifications/$id"));

  if (resp.statusCode != 200) throw Exception("Invalid Response");

  return jsonDecode(resp.body);
}

Widget Listview(BuildContext context) {
  return FutureBuilder(
    future: getNotifications(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        var data = snapshot.data as List;
        if (data.isEmpty) {
          return Center(
            child: Text("No Notifications."),
          );
        }
        return ListView.separated(
            itemBuilder: (context, index) {
              return ListviewItem(context, data[index] as Map<String, dynamic>);
            },
            separatorBuilder: (context, index) {
              return Divider(height: 1);
            },
            itemCount: data.length);
      } else if (snapshot.hasError) {
        return Center(child: Text("Error: ${snapshot.error}"));
      }

      return Center(child: CupertinoActivityIndicator());
    },
  );
}

Widget ListviewItem(BuildContext context, Map<String, dynamic> itemDetails) {
  return Container(
      margin: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrefixIcon(),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  message(context, itemDetails),
                  timeanddate(
                    itemDetails,
                  )
                ],
              ),
            ),
          ),
        ],
      ));
}

Widget PrefixIcon() {
  return Container(
    height: 50,
    width: 50,
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.grey.shade300,
    ),
    child: Icon(
      Icons.notifications,
      size: 25,
      color: Colors.grey.shade700,
    ),
  );
}

Widget message(BuildContext context, Map<String, dynamic> itemDetails) {
  double textsize = 17;

  return GestureDetector(
    onTap: () {
      // print(itemDetails['user']['_id']);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UserNotifierInfo(
                  userId: itemDetails['user']['_id'],
                )),
      );
    },
    child: RichText(
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
          text: itemDetails['user']['username'],
          style: TextStyle(
            fontSize: textsize,
            color: primarycolor,
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
                text: ' liked your listing: ${itemDetails['product']['title']}',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                ))
          ]),
    ),
  );
}

Widget timeanddate(Map<String, dynamic> itemDetails) {
  return Container(
    margin: EdgeInsets.only(top: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY)
              .format(DateTime.parse(itemDetails['createdAt'])),
          style: TextStyle(fontSize: 13),
        ),
        Text(
          DateFormat(DateFormat.HOUR_MINUTE).format(DateTime.parse(
            itemDetails['createdAt'],
          ).toLocal()),
          style: TextStyle(fontSize: 14),
        )
      ],
    ),
  );
}

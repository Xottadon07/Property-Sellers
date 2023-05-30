import 'package:dale_the_property_sellers/model/product.dart';
import 'package:dale_the_property_sellers/pages/constants.dart';
import 'package:dale_the_property_sellers/pages/ename.dart';
import 'package:dale_the_property_sellers/pages/favorite_button.dart';
// import 'package:dale_the_property_sellers/pages/search_bar.dart';
import 'package:dale_the_property_sellers/pages/slider/slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:dale_the_property_sellers/pages/recommended_page.dart';
import 'package:http/http.dart' as http;
import 'package:http/src/utils.dart' as http_utils;
import 'dart:convert';
// import 'package:url_launcher/url_launcher.dart';

import 'BottomBar.dart';
// import 'Custom_appbar.dart';

class IndividualPage extends StatefulWidget {
  final Product product;

  IndividualPage({Key? key, required this.product});

  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool islike = false;
  final Color inactiveColor = Colors.white;
  String output = '';
  final _formKey = GlobalKey<FormState>();
  String _name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Property Detail'),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedMenu: MenuState.userprofile,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String toCall = "009779814117721";
          if (widget.product.uploader != null) {
            toCall = widget.product.uploader!.phoneNumber;
          }
          await FlutterPhoneDirectCaller.callNumber(toCall);
        },
        child: Icon(Icons.phone),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.product.image),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.title,
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Rs.${widget.product.price}",
                            style: TextStyle(
                              color: primarycolor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      FavoriteButton(product: widget.product),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 140,
                          child: DetailCard(
                              icon: Icons.location_city,
                              text: widget.product.location),
                        ),
                      ),
                      SizedBox(
                        height: 140,
                        child: DetailCard(
                            icon: Icons.category, text: widget.product.purpose),
                      ),
                      SizedBox(
                        height: 140,
                        child: DetailCard(
                            icon: Icons.area_chart,
                            text: "${widget.product.area} sq feet"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: TextStyle(
                            color: primarycolor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.product.description,
                          style: TextStyle(
                            color: Color.fromARGB(255, 95, 95, 95),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  if (widget.product.uploader != null)
                    Column(
                      children: [
                        Text(
                          'Owner details',
                          style: TextStyle(
                            color: primarycolor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Uploaded by : ${widget.product.uploader!.username}'),
                              Text('Email : ${widget.product.uploader!.email}'),
                              Text(
                                  'Phone No : ${widget.product.uploader!.phoneNumber}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  Container(
                    child: ElevatedButton(
                      onPressed: () {
                        Future<void> fetchData() async {
                          var url = Uri.parse('http://10.0.0.2:5000/recommend');
                          var newRequest = http.MultipartRequest('POST', url);
                          newRequest.fields['title'] =
                              'Siddarthcolony 7 Ana Home : House For Sale In Budhanilkantha, Kathmandu';
                          // var data = {'title': widget.product.title};
                          // var headers = {
                          //   'Content-Type': 'application/x-www-form-urlencoded',
                          // };
                          // var body = http_utils.mapToQuery(data);
                          // var response = await http.post(url,
                          // headers: headers, body: body);

                          // if (response.statusCode == 200) {
                          //   final Data = (response.body);
                          //   final jsonString = json
                          //       .encode(Data); // Convert back to JSON string
                          //   setState(() {
                          //     output = jsonString;
                          // });
                          await newRequest.send();
                        }
                      }

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         OutputPage(data: output),
                      //   ),
                      // );

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => OutputPage()),
                      // );
                      // TODO: Add button press logic here
                      ,
                      child: Text('Recommended'),
                    ),
                  ),
                ], //children
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DetailCard extends StatelessWidget {
  final IconData icon;
  final String text;

  const DetailCard({Key? key, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 110,
        height: 110,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: primarycolor,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              text,
              style: TextStyle(
                color: Color.fromARGB(255, 95, 95, 95),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ));
  }
}

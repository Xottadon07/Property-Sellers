// ignore_for_file: prefer_const_constructors

import 'package:dale_the_property_sellers/controllers/products_controller.dart';
// import 'package:dale_the_property_sellers/pages/Home_screen.dart';
import 'package:dale_the_property_sellers/pages/category/category.dart';
// import 'package:dale_the_property_sellers/pages/constants.dart';
// import 'package:dale_the_property_sellers/pages/login_page.dart';
// import 'package:dale_the_property_sellers/pages/main_pages/property_list.dart';
// import 'package:dale_the_property_sellers/pages/main_pages/user_profile.dart';
import 'package:dale_the_property_sellers/pages/products/recent_products.dart';
// import 'package:dale_the_property_sellers/pages/signup_page.dart';
import 'package:dale_the_property_sellers/pages/slider/slider.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'Custom_appbar.dart';
import 'drawer.dart';
// import 'main_pages/subprofile/myinformation.dart';
import 'products/expandproducts.dart';
// import 'search_bar.dart';

class homebody extends StatefulWidget {
  const homebody({Key? key}) : super(key: key);

  @override
  State<homebody> createState() => _homebodyState();
}

class _homebodyState extends State<homebody> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductController>(
        builder: (context, productController, child) {
      return Scaffold(
        //using safearea to show appbar
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      print('asdasd');
                      Future<void> fetchData() async {
                        var url =
                            Uri.parse('http://192.168.1.65:5000/recommend');
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
                CustomAppBar(),
                //create column and row inside it
                //space between bar and  search
                // ignore: prefer_const_constructors
                // SearchBar(),
                //to create slider
                //we create asset foler and import the required images
                // giving image folder path in pubspec
                ProductSlider(),
                //defininig size for categories
                // SizedBox(
                //   height: 20,
                // ),
                Category(),
                // SizedBox(
                //   height: 20,
                // ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recomended',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto-black',
                          color: Colors.black,
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.push(
                            context,
                            PageTransition(
                                duration: Duration(microseconds: 200),
                                type: PageTransitionType.rightToLeft,
                                child: ExpandProd())),
                        child: Column(
                          children: [
                            Text(
                              'See all',
                              style:
                                  TextStyle(fontSize: 17, color: Colors.black),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(height: 330, child: RecentProducts()),
              ],
            ),
          ),
        ),
        drawer: drawer(),
      );
    });
  }
}

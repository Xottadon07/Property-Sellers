import 'package:dale_the_property_sellers/pages/main_pages/property_list.dart';
import 'package:flutter/material.dart';
import 'package:dale_the_property_sellers/pages/constants.dart';
// import 'package:dale_the_property_sellers/pages/main_pages/search_page.dart';
// import 'package:dale_the_property_sellers/pages/ename.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class SearchBarScreen extends StatelessWidget {
  const SearchBarScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Popular Now',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto-black',
              color: Colors.black87,
            ),
          ),
          // Expanded(
          //   child: Container(
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(20),
          //         boxShadow: [
          //           BoxShadow(
          //               //shadow color
          //               color: Colors.black38,
          //               blurRadius: 4)
          //         ],
          //       ),
          //       child: TextField(
          //         decoration: InputDecoration(
          //           contentPadding: EdgeInsets.symmetric(vertical: 14),
          //           //remove bar
          //           enabledBorder: OutlineInputBorder(
          //             borderSide: BorderSide.none,
          //           ),
          //           focusedBorder: OutlineInputBorder(
          //             borderSide: BorderSide.none,
          //           ),
          //           prefixIcon: Icon(Icons.search),
          //         ),
          //       )),
          // ),
          //sorting botton
          SizedBox(
            width: 10,
          ),
          Container(
            decoration: BoxDecoration(
                color: primarycolor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 4)]),
            child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PropScreen()));
                },
                icon: Icon(Icons.sort)),
          )
        ],
      ),
    );
  }
}

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class RecommendedPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Recommended'),
//       ),
//       body: Center(
//         child: Text('Recommended Page'),
//       ),
//     );
//   }
// }
// class OutputPage extends StatefulWidget {
//   @override
//   _OutputPageState createState() => _OutputPageState();
// }

// class _OutputPageState extends State<OutputPage> {
//   String output = '';

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     final response =
//         await http.get(Uri.parse('http://127.0.0.1:5000/recommend'));
//     if (response.statusCode == 200) {
//       final decodedData = jsonDecode(response.body);
//       setState(() {
//         output = decodedData['message'];
//       });
//     } else {
//       setState(() {
//         output = 'Error retrieving data';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Output Page'),
//       ),
//       body: Center(
//         child: Text(output),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: OutputPage(),
//   ));
// }
import 'package:dale_the_property_sellers/model/product.dart';
import 'package:dale_the_property_sellers/pages/ename.dart';
import 'package:dale_the_property_sellers/pages/individualPage.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OutputPage extends StatefulWidget {
  @override
  _OutputPageState createState() => _OutputPageState();
  // final String data = '';
//   IndividualPage({required this.data})
}

class _OutputPageState extends State<OutputPage> {
  String output = '';

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:5000/recommend'));
    if (response.statusCode == 200) {
      final Data = (response.body);
      final jsonString = json.encode(Data); // Convert back to JSON string
      setState(() {
        output = jsonString;
      });
    } else {
      setState(() {
        output = 'Error retrieving data';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Output Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(output),
          SizedBox(height: 16),
          Text(
            output,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: OutputPage(),
  ));
}

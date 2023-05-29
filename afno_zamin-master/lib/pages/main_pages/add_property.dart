import 'dart:convert';
import 'dart:io';

import 'package:dale_the_property_sellers/controllers/products_controller.dart';
import 'package:dale_the_property_sellers/pages/constants.dart';
import 'package:dale_the_property_sellers/pages/ename.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../model/product.dart';

import '../BottomBar.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final formkey = GlobalKey<FormState>();
  List<String> purposes = ['Rent', "Sell"];
  late String _selectedPurpose = purposes[0];

  List<String> propertyType = ['Land', 'House', "Commercial"];
  late String _selectedProperty = propertyType[0];

  final ImagePicker _picker = ImagePicker();
  String? imagepath;
  //changes
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future pickImage() async {
    try {
      final pickedfile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedfile != null) {
        setState(() {
          imagepath = pickedfile.path;
        });
      }
    } catch (e) {
      print('fail to select');
    }
  }

  void addProduct() async {
    try {
      var loggedInUserDetails =
          await FlutterSecureStorage().read(key: "ZAMIN_USER");
      if (loggedInUserDetails == null) {
        throw Exception("Login needed");
      }

      var parsed = jsonDecode(loggedInUserDetails);
      var id = parsed['_id'];
      if (id == null) throw Exception("Unable to find user id");

      var request =
          http.MultipartRequest("POST", Uri.parse("$kApiURL/addProduct"));
      request.fields['title'] = titleController.text;
      request.fields['price'] = priceController.text;
      request.fields['description'] = descriptionController.text;
      request.fields['area'] = areaController.text;
      request.fields['location'] = locationController.text;
      request.fields['purpose'] = _selectedPurpose;
      request.fields['category'] = _selectedProperty;
      request.fields['user'] = id!;
      if (imagepath != null) {
        request.files
            .add(await http.MultipartFile.fromPath('image', imagepath!));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please choose an image first.')));
        return;
      }

      print(request.fields);
      print(request.files);

      request.send().then((response) {
        if (response.statusCode == 200) {
          response.stream.bytesToString().then((value) {
            Provider.of<ProductController>(context, listen: false)
                .addNew(Product.fromJson(jsonDecode(value)));
          });

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('uploaded')));
          Navigator.of(context).pop();
          // ignore: use_build_context_sync
          //hronously, unnecessary_new
          // Navigator.push(context, new MaterialPageRoute(builder: (context) => LoginPage()));

        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('failed to upload')));
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Add  property'),
          // backgroundColor: Colors.white,
        ),
        resizeToAvoidBottomInset: true,
        body: ListView(
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/Afnoz.png")),
              ),
            ),
            Center(
              child: Text(
                "Add Your Property",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
            ),
            SizedBox(height: 17),
            Form(
                key: formkey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 35),
                    child: Column(children: [
                      TextFormField(
                        controller: titleController,
                        decoration: InputDecoration(
                          hintText: "Enter Property Title",
                          labelText: "Title",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Title';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: priceController,
                        decoration: InputDecoration(
                          hintText: "Enter Price in Rs",
                          labelText: "Price",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Price';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: areaController,
                        decoration: InputDecoration(
                          hintText: "Enter Area in sq feet",
                          labelText: "Area",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Area';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: locationController,
                        decoration: InputDecoration(
                          hintText: "Enter Location",
                          labelText: "Location",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Location';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 9),
                      // DropdownButton(items: purposeValues.map((p){ return  DropDownMenuItem(child: Text(p), value: p)}).toList()),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          border: Border.all(
                            color: primarycolor,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: DropdownButton(
                            isExpanded: true,
                            value: _selectedPurpose,
                            items: purposes
                                .map((e) => DropdownMenuItem(
                                      child: Text(e),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (v) {
                              if (v != null) {
                                _selectedPurpose = (v as String);
                                setState(() {});
                              }
                            }),
                      ),

                      SizedBox(height: 9),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          // border: Border.all(
                          // color: primarycolor,
                          //     ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: DropdownButton(
                            isExpanded: true,
                            value: _selectedProperty,
                            items: propertyType
                                .map((e) => DropdownMenuItem(
                                      child: Text(e),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (v) {
                              if (v != null) {
                                _selectedProperty = (v as String);
                                setState(() {});
                              }
                            }),
                      ),
                      TextFormField(
                        controller: descriptionController,
                        keyboardType: TextInputType.multiline,
                        minLines: 1, //Normal textInputField will be displayed
                        maxLines: 7,
                        decoration: InputDecoration(
                          hintText: "Enter Description",
                          labelText: "Description",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Description';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          // _picker.pickImage(source:ImageSource.gallery);
                          pickImage();
                        },
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: primarycolor))),
                            child: Text(
                              "Upload image",
                              style: TextStyle(
                                  color: primarycolor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 25),

                      ElevatedButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            addProduct();
                            print('ok');
                            // Navigator.pushNamed(context, MyRoutes.homeRoute);
                          } else {
                            print('not ok');
                          }
                        },
                        style: TextButton.styleFrom(minimumSize: Size(100, 40)),
                        child: Text(
                          "ADD PROPERTY",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 20),
                    ])))
          ],
        ),
        bottomNavigationBar: BottomNavBar(selectedMenu: MenuState.addpropery));

    // );
  }
}

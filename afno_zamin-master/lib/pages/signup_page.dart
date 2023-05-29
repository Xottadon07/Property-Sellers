import 'dart:convert';

import 'package:dale_the_property_sellers/pages/constants.dart';
import 'package:dale_the_property_sellers/pages/login_page.dart';
import 'package:dale_the_property_sellers/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _isVisible = false;
  String name = "";
  final formkey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void loginProcess() async {
    var data = {
      'username': usernameController.text,
      'password': passwordController.text,
      'phoneNumber': phoneNumberController.text,
      'email': emailController.text
    };
    var bodyPart = json.encode(data);
    try {
      Response response = await http.post(Uri.parse("$kApiURL/signup"),
          body: bodyPart, headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200 &&
          jsonDecode(response.body.toString()) != null) {
        print('Registration successful ');
        // ignore: use_build_context_synchronously, unnecessary_new
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        print('failed to signup');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // ignore: prefer_typing_uninitialized_variables
  var confirmPass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 18.0),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                  child: Image.asset(
                    "assets/images/Afnoz.png",
                    fit: BoxFit.cover,
                    height: 150,
                  ),
                ),
                Text(
                  "Join Us",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                      color: primarycolor),
                ),
                SizedBox(height: 10),
                Form(
                  key: formkey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 35),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            hintText: "Enter Username",
                            labelText: "Username",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter UserName';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: !_isVisible,
                          // obscureText: true,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isVisible = !_isVisible;
                                });
                              },
                              icon: _isVisible
                                  ? Icon(
                                      Icons.visibility,
                                      color: Colors.black,
                                    )
                                  : Icon(
                                      Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                            ),
                            hintText: "Enter Password",
                            labelText: "Password",
                          ),
                          validator: (value) {
                            confirmPass = value;
                            if (value == null || value.isEmpty) {
                              return 'Please enter Password';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          obscureText: !_isVisible,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isVisible = !_isVisible;
                                });
                              },
                              icon: _isVisible
                                  ? Icon(
                                      Icons.visibility,
                                      color: Colors.black,
                                    )
                                  : Icon(
                                      Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                            ),
                            hintText: "Confirm Password",
                            labelText: "Confirm Password",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Password';
                            } else if (value != confirmPass) {
                              return "Password must be same as above";
                            }

                            return null;
                          },
                        ),
                        TextFormField(
                          controller: phoneNumberController,
                          decoration: InputDecoration(
                            hintText: "Enter PhoneNumber",
                            labelText: "PhoneNumber",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter PhoneNumber';
                            } else if (value.length != 10) {
                              return "Phone Number Must be 10 digits";
                            }

                            return null;
                          },
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: "Enter Email",
                            labelText: "EmailAddress",
                          ),
                        ),
                        SizedBox(height: 25),
                        ElevatedButton(
                          style:
                              TextButton.styleFrom(minimumSize: Size(110, 40)),
                          child: Text(
                            "SignUp",
                            style: TextStyle(fontSize: 16),
                          ),
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              loginProcess();
                              print('ok');
                            } else {
                              print("not ok");
                            }
                          },
                        ),
                        SizedBox(height: 35),
                        Center(
                            child: Row(
                          children: [
                            Text(
                              'Already have an account? ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: primarycolor))),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, MyRoutes.loginRoute);
                                },
                                child: Text("Log IN",
                                    style: TextStyle(
                                        color: primarycolor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                              ),
                            ),

                            // alignment: Alignment.center,
                          ],
                        )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

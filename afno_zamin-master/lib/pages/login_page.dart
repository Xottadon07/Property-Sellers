import 'package:dale_the_property_sellers/model/user.dart';
import 'package:dale_the_property_sellers/pages/Home_screen.dart';
import 'package:dale_the_property_sellers/pages/constants.dart';
import 'package:dale_the_property_sellers/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "";
  bool _isVisible = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void loginProcess() async {
    var data = {
      'username': usernameController.text,
      'password': passwordController.text
    };
    var bodyPart = json.encode(data);
    try {
      Response response = await http.post(Uri.parse("$kApiURL/login"),
          body: bodyPart, headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200 &&
          jsonDecode(response.body.toString()) != null) {
        FlutterSecureStorage().write(
          key: "ZAMIN_USER",
          value: response.body.toString(),
        );

        print('Login successfully');
        print(jsonDecode(response.body.toString()));

        const FlutterSecureStorage().write(
          key: "ZAMIN_USER",
          value: response.body.toString(),
        );

        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        print('fail to login');
        Fluttertoast.showToast(
            msg: "INVALID USER",
            toastLength: Toast.LENGTH_SHORT, // length
            gravity: ToastGravity.CENTER, // location
            timeInSecForIosWeb: 5);
        // message
      }
    } catch (e) {
      print(e.toString());
    }
  }

  User user = User('', '', '', '');
  var confirmPass;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 100, 20, 20),
              child: Image.asset(
                "assets/images/Afnoz.png",
                fit: BoxFit.cover,
                height: 160,
              ),
            ),
            Text(
              "welcome $name",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                  color: primarycolor),
            ),
            SizedBox(height: 16),
            Form(
              key: formKey,
              //autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter Username",
                        labelText: "Username",
                      ),
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Required"),
                        PatternValidator((r'^[a-z A-Z]+$'),
                            errorText: 'Character only')
                      ]),
                      controller: usernameController,
                      onChanged: (value) {
                        name = value;
                        setState(() {});
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
                    SizedBox(height: 35),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          loginProcess();
                          print('ok');
                        } else {
                          print("not ok");
                        }
                      },
                      style: TextButton.styleFrom(minimumSize: Size(100, 40)),
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: Row(children: [
                        Text("Don't Have an Account? ",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, MyRoutes.signupRoute);
                          },
                          child: Center(
                            child: Container(
                              // // height: 40,
                              // width: 60,
                              child: Text("SIGN UP",
                                  style: TextStyle(
                                      color: primarycolor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),

                              // alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: primarycolor))),
                            ),
                          ),
                        )
                      ]),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

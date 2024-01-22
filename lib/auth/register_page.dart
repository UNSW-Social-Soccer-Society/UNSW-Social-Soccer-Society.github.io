// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/svg.dart';
import 'package:src/auth/register_success.dart';
import 'package:src/util/login_button.dart';
import 'package:src/util/login_textfield.dart';

import '../../../server_vars.dart' as server;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final firstController = TextEditingController();
  final lastController = TextEditingController();
  final emailController = TextEditingController();
  final zidController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // dropdown variables
  String graduation = "Select Graduation Year";
  String faculty = "Select Your Faculty";

  // checkbox varibles
  bool arc = false;

  // error variables
  var invalidEmail = false;
  var userAlreadyRegistered = false;
  var unselected = false;
  var fieldEmpty = false;
  var exceededCharLimitFirst = false;
  var exceededCharLimitLast = false;
  var invalidzid = false;
  var error = false;

  // sign user up method
  void register() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // check all field are filled in
    setState(() {
      error = false;
      invalidEmail = false;
      userAlreadyRegistered = false;
      unselected = false;
      fieldEmpty = false;

      if (firstController.text.trim() == "") {
        fieldEmpty = true;
        error = true;
      }
      if (lastController.text.trim() == "") {
        fieldEmpty = true;
        error = true;
      }
      if (emailController.text.trim() == "") {
        fieldEmpty = true;
        error = true;
      }
      if (zidController.text.trim() == "") {
        fieldEmpty = true;
        error = true;
      }

      // check username, firstname and lastname are not too long
      else if (zidController.text.length != 7) {
        invalidzid = true;
        fieldEmpty = false;
        error = true;
      }
      // Check dropdowns are selected
      else if (graduation == "Select Graduation Year" ||
          faculty == "Select Your Faculty") {
        unselected = true;
        invalidzid = false;
        fieldEmpty = false;
        error = true;
      }
    });

    if (error == true) {
      Navigator.pop(context);
      return;
    }

    // Disable certificate validation
    /// Create an HttpClient with custom certificate validation
    HttpClient httpClient = HttpClient();
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

    // // send post request to the server
    // var responseString = await http.post(
    //   Uri.https(server.url, 'register_website/'),
    //   headers: {
    //     "Content-Type": "application/json",
    //   },
    //   body: jsonEncode({
    //     'firstname': firstController.text,
    //     'lastname': lastController.text,
    //     'email': emailController.text,
    //     'zID': int.parse(zidController.text),
    //     'degree': faculty,
    //     'arc': arc,
    //     'graduation': graduation,
    //   }),
    // );

    // final response = json.decode(responseString.body);

    HttpClientRequest request =
        await httpClient.postUrl(Uri.https(server.url, 'register_website/'));
    request.headers.set('Content-Type', 'application/json');
    request.add(utf8.encode(json.encode({
      'firstname': firstController.text,
      'lastname': lastController.text,
      'email': emailController.text,
      'zID': int.parse(zidController.text),
      'degree': faculty,
      'arc': arc,
      'graduation': graduation,
    })));
    HttpClientResponse responseString = await request.close();

    // Read and decode the response body
    String responseBody = await utf8.decodeStream(responseString);

    // Parse the JSON response
    final response = json.decode(responseBody);

    // error handling
    if (response['success'] == false) {
      Navigator.pop(context);
      switch (response['error']) {
        case "Invalid email address":
          {
            setState(() {
              invalidEmail = true;
              userAlreadyRegistered = false;
              unselected = false;
              error = true;
            });
          }
          break;
        case "User already registered":
          {
            setState(() {
              invalidEmail = false;
              userAlreadyRegistered = true;
              unselected = false;
              error = true;
            });
          }
          break;
      }
      return;
    }

    // successful registration
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegisterSuccess()));
  }

  showText() {
    if (invalidEmail) return "Enter a valid email address";
    if (unselected) return "Select the dropdown menus";
    if (userAlreadyRegistered) {
      return "You have already registered!";
    }
    if (invalidzid) return "zID is invalid";
    if (fieldEmpty) return "Fill in all the fields!";
    return "Welcome! Lets get you set up";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/logo.svg',
                    height: 200,
                  ),

                  const SizedBox(height: 0),

                  const Text("UNSW Social Soccer Society",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 70, 70, 80),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      )),
                  const Text("Registration",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 70, 70, 80),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      )),

                  const SizedBox(height: 50),

                  // welcome back
                  Text(showText(),
                      style: TextStyle(
                        color: error
                            ? Colors.red
                            : const Color.fromARGB(255, 70, 70, 80),
                        fontSize: 16,
                      )),

                  const SizedBox(height: 50),

                  // name textfields
                  Container(
                    child: exceededCharLimitFirst ||
                            (firstController.text == "" && fieldEmpty)
                        ? LoginTextField(
                            controller: firstController,
                            hintText: "First Name",
                            obscureText: false,
                            error: true,
                          )
                        : LoginTextField(
                            controller: firstController,
                            hintText: "First Name",
                            obscureText: false,
                            error: false,
                          ),
                  ),

                  const SizedBox(height: 5),

                  Container(
                    child: exceededCharLimitLast ||
                            (lastController.text == "" && fieldEmpty)
                        ? LoginTextField(
                            controller: lastController,
                            hintText: "Last Name",
                            obscureText: false,
                            error: true,
                          )
                        : LoginTextField(
                            controller: lastController,
                            hintText: "Last Name",
                            obscureText: false,
                            error: false,
                          ),
                  ),

                  const SizedBox(height: 25),

                  // zID textfield
                  Container(
                    child:
                        invalidzid || (zidController.text == "" && fieldEmpty)
                            ? LoginTextField(
                                controller: zidController,
                                hintText: "zID (without the z)",
                                obscureText: false,
                                error: true,
                                numeric: true,
                              )
                            : LoginTextField(
                                controller: zidController,
                                hintText: "zID (without the z)",
                                obscureText: false,
                                error: false,
                                numeric: true,
                              ),
                  ),

                  const SizedBox(height: 25),

                  // email textfield
                  Container(
                    child: (invalidEmail || userAlreadyRegistered) ||
                            (emailController.text == "" && fieldEmpty)
                        ? LoginTextField(
                            controller: emailController,
                            hintText: "Email",
                            obscureText: false,
                            error: true,
                          )
                        : LoginTextField(
                            controller: emailController,
                            hintText: "Email",
                            obscureText: false,
                            error: false,
                          ),
                  ),

                  const SizedBox(height: 25),

                  DropdownButton<String>(
                    value: graduation,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: Colors.grey,
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        graduation = newValue.toString();
                      });
                    },
                    items: const [
                      "Select Graduation Year",
                      "2024",
                      "2025",
                      "2026",
                      "2027",
                      "2028",
                      "2029",
                      "2030",
                      "2031",
                      "2032"
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 25),

                  DropdownButton<String>(
                    value: faculty,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: Colors.grey,
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        faculty = newValue.toString();
                      });
                    },
                    items: const [
                      "Select Your Faculty",
                      "Arts, Design, Architecture",
                      "Business",
                      "Engineering",
                      "Law and Justice",
                      "Medicine and Health",
                      "Science",
                      "Postgraduate",
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 40),

                  const Text('Are you an Arc member?'),
                  Checkbox(
                    value: arc,
                    activeColor: Colors.grey[800],
                    onChanged: (value) {
                      setState(() {
                        arc = value!;
                      });
                    },
                  ),

                  const SizedBox(height: 50),

                  // sign in button
                  LoginButton(onTap: register, text: "Register"),

                  const SizedBox(height: 50)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

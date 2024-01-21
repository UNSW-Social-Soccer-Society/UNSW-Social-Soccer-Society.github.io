// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:src/auth/register_page.dart';

import 'package:src/util/login_button.dart';

class RegisterSuccess extends StatefulWidget {
  @override
  State<RegisterSuccess> createState() => _RegisterSuccessState();
}

class _RegisterSuccessState extends State<RegisterSuccess> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
    
                  // logo
                  const Icon(
                    Icons.verified_user_rounded,
                    size: 100,
                  ),
    
                  const SizedBox(height: 50),
    
                  // welcome back
                  const Text("Registered!",
                      style: TextStyle(
                        color: Color.fromARGB(255, 70, 70, 80),
                        fontSize: 24,
                      )),
    
                  const SizedBox(height: 50),
    
                  // sign in button
                  LoginButton(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage())),
                      text: "Back"),
    
                  const SizedBox(height: 100)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

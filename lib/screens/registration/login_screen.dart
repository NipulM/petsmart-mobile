// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();

  String email = "";
  String pass = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login Page :)',
              style: TextStyle(
                fontFamily: "Signika Regular",
                fontWeight: FontWeight.bold, // Use font weight to specify bold
              )),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.all(35),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              height: 475, // Set the color to red
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Login",
                      style: TextStyle(
                        fontFamily: "Signika Regular",
                        fontSize: 24,
                        fontWeight:
                            FontWeight.bold, // Use font weight to specify bold
                      )),
                  Text("Welcome Back!",
                      style: TextStyle(
                        fontFamily: "Signika Regular",
                        fontSize: 24,
                        fontWeight:
                            FontWeight.bold, // Use font weight to specify bold
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelStyle: TextStyle(
                                fontFamily: "Signika Regular",
                              ),
                              labelText: "Email Address",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            controller: emailAddress,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(
                                fontFamily: "Signika Regular",
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            controller: password,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: SizedBox(
                      width: double.infinity,
                      height: 65, // Adjust the height of the button
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            email = emailAddress.text;
                            pass = password.text;
                            print("Email: $email");
                            print("Password: $pass");
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF7754F6),
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text("Log in",
                            style: TextStyle(
                              fontFamily: "Signika Regular",
                              fontSize: 20,
                              color: Colors
                                  .white, // Use font weight to specify bold
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Center the row's children horizontally
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            fontFamily: "Signika Regular",
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Sign up",
                          style: TextStyle(
                            fontFamily: "Signika Regular",
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

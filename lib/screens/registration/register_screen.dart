// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cb011999/screens/registration/login_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameInput = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();

  String name = "";
  String email = "";
  String pass = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('',
              style: TextStyle(
                fontFamily: "Roboto Regular",
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
                  Text("Singup",
                      style: TextStyle(
                        fontFamily: "Roboto Regular",
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
                                fontFamily: "Roboto Regular",
                              ),
                              labelText: "Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            controller: nameInput,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelStyle: TextStyle(
                                fontFamily: "Roboto Regular",
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
                                fontFamily: "Roboto Regular",
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
                            name = nameInput.text;
                            email = emailAddress.text;
                            pass = password.text;

                            if (email.isEmpty || pass.isEmpty || name.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Email and password or name cannot be empty.'),
                                ),
                              );
                              return;
                            }

                            if (!email.contains('@')) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Please enter a valid email address.'),
                                ),
                              );
                              return;
                            }
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
                        child: Text("Signup",
                            style: TextStyle(
                              fontFamily: "Roboto Regular",
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
                          "Already have an account? ",
                          style: TextStyle(
                            fontFamily: "Roboto Regular",
                            fontSize: 16,
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              // push replacement because i dont wanna repeat the login screen
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                              );
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontFamily: "Roboto Bold",
                                fontSize: 16,
                                color: Colors.blue,
                              ),
                            )),
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

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cb011999/screens/registration/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<void> register(email, password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'User $name with email $email has been registered successfully.'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An unexpected error occurred. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final orientation = MediaQuery.of(context).orientation;

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
              width: orientation == Orientation.portrait
                  ? MediaQuery.of(context).size.width * 0.9
                  : MediaQuery.of(context).size.width * 0.6,
              margin: EdgeInsets.all(35),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isDarkMode ? Color(0xFF2C2C2C) : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: isDarkMode
                        ? Colors.black.withOpacity(0.3)
                        : Colors.grey.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
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

                            register(email, pass);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
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

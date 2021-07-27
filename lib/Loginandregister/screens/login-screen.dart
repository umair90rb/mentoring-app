import 'package:brain_store/BottomNavigationbar/BottomNatigation_page.dart';
import 'package:brain_store/BottomNavigationbar/Botton_nav_widget/Home_Screen.dart';
import 'package:brain_store/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nice_button/nice_button.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'create-new-account.dart';
import 'forgot-password.dart';
import 'confirm_email.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthServices auth = AuthServices();

  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  bool _showPassword = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                SafeArea(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontFamily: "Raleway",
//                        fontFamily: "Abril Fatface",
                            //  fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateNewAccount()),
                            );
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 17,
                              fontFamily: "Raleway",
//                        fontFamily: "Abril Fatface",
                              //  fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50, right: 270),
                  child: Container(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // Padding(
                //  padding: EdgeInsets.only(top: 40, right: 50),
                // child: Container(
                //   child: Row(children: <Widget>[
                //     Text("")
                //   ],),

                // ),
                // ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: TextFormField(
                    controller: email,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Your Email';
                      }
                      return null;
                    },
                    cursorWidth: 1.5,
                    cursorColor: Colors.orange,
                    decoration: InputDecoration(
                      labelText: "Email address",
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: "Raleway",
                      ),
                      fillColor: Colors.transparent,
//                      prefixIcon: Icon(Icons.email),
                      contentPadding: EdgeInsets.all(16),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    style: new TextStyle(
                      fontFamily: "Raleway",
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: TextFormField(
                    controller: password,
                    cursorColor: Colors.orange,
                    validator: (value) {
                      if (value.length < 6) {
                        return 'Please Enter Password';
                      }
                      return null;
                    },
                    obscureText: true,
                    cursorWidth: 1.5,
                    decoration: InputDecoration(
                      labelText: "Password",
                      fillColor: Colors.transparent,
                      focusColor: Colors.orange,
                      hoverColor: Colors.orange,
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: "Raleway",
                      ),
//                      prefixIcon: Icon(Icons.security),
                      contentPadding: EdgeInsets.all(16),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        borderSide: BorderSide(color: Colors.orange),
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    style: new TextStyle(
                      fontFamily: "Raleway",
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 32),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgetPassword()),
                        );
                      },
                      child: Text(
                        "Forgot Your Password?",
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 16,
                          fontFamily: "Raleway",
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: SizedBox(
                    width: 370.0,
                    height: 50.0,
                    child: RaisedButton(
                      splashColor: Colors.white,
                      elevation: 2,
                      color: Color(0xFF1A3A77),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          ProgressDialog dialog = ProgressDialog(context);
                          dialog.style(message: 'Please wait...',progressTextStyle: TextStyle(fontFamily: "Raleway",));
                          await dialog.show();
                          auth
                              .emailSignIn(email.text, password.text)
                              .then((value) async {
                            if (value != null) {
                              await dialog.hide();
                              value.emailVerified
                                  ? Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BottomNavigationPage()),
                                    )
                                  : showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          clipBehavior: Clip.hardEdge,
                                          // titlePadding: EdgeInsets.all(10),
                                          // contentPadding: EdgeInsets.all(10),
                                          title: Text(
                                            'Confirm your Email!',
                                            style: TextStyle(
                                              fontFamily: "Raleway",
                                            ),
                                          ),
                                          content: Text(
                                            'Please confirm your email address. Check your email and click on the link and login again.',
                                            style: TextStyle(
                                              fontFamily: "Raleway",
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                    fontFamily: "Raleway",
                                                  ),
                                                )),
                                          ],
                                        );
                                      });
                            } else {
                              await dialog.hide();
                              Fluttertoast.showToast(
                                msg: "Invalid Usename/Password!",
                                toastLength: Toast.LENGTH_SHORT,
                              );
                            }
                          });
                        }
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Raleway",
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 20,
                // ),
                // Text("OR"),
                // SizedBox(
                //   height: 20,
                // ),
                // InkWell(
                //   onTap: () {},
                //   child: Container(
                //     height: 50,
                //     width: size.width * 0.85,
                //     decoration: BoxDecoration(
                //       color: Colors.blue[900],
                //       borderRadius: BorderRadius.circular(50),
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                //       children: [
                //         // Image.asset("assets/images/facebook.png", color: Color.fromRGBO(59, 89, 153, 1),),
                //         Text(
                //           "Continue with Facebook",
                //           style: TextStyle(
                //             letterSpacing: 2,
                //             color: Colors.white,
                //             fontSize: 17,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

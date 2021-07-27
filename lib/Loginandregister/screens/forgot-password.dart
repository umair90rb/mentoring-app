import 'package:brain_store/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({Key key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController email = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AuthServices auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Forgotten Password?",
          style: TextStyle(color: Colors.black, fontFamily: "Raleway"),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFFAFAFA),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(),
                  child: Container(
                    height: 5,
                    color: Color(0xFF1A3A77),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(left: 28),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'No Worries',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Raleway",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(left: 26, top: 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Let's fix this so you can use Comrade",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              // fontWeight: FontWeight.bold,
                              fontFamily: "Raleway",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: TextFormField(
                    controller: email,
                    cursorColor: Colors.orange,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Correct Email';
                      }
                      return null;
                    },
                    cursorWidth: 1.5,
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
                  height: 40,
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
                          dialog.style(
                              message: 'Please wait...',
                              progressTextStyle:
                                  TextStyle(fontFamily: "Raleway"));
                          await dialog.show();
                          auth.forgotPassword(email.text).then((value) async {
                            print(value);
                            if (value != null) {
                              await dialog.hide();
                              Fluttertoast.showToast(
                                  msg: "Reset link send to your email!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              await dialog.hide();
                              Fluttertoast.showToast(
                                  msg: "Something goes wrong!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          });
                        }
                      },
                      child: Text(
                        "Reset Password",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Raleway",
                            fontSize: 20),
                      ),
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

import 'package:brain_store/Loginandregister/screens/login-screen.dart';

import '../../services/auth.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ConfirmEmail extends StatelessWidget {
  AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'An email sent to you when you register. Click the link provided to complete registration',
              style: TextStyle(
                fontSize: 18,
                fontFamily: "Raleway",
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Don\'t receive email?',
              style: TextStyle(
                fontFamily: "Raleway",
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  ProgressDialog dialog = ProgressDialog(context);
                  dialog.style(
                      message: 'Please wait...',
                      progressTextStyle: TextStyle(fontFamily: "Raleway"));
                  await dialog.show();
                  await _auth.sendEmailVerificationLink();
                  await dialog.hide();
                  ScaffoldState().showSnackBar(SnackBar(
                      content: Text(
                    'Verification link sent! Check your email.',
                    style: TextStyle(
                      fontFamily: "Raleway",
                    ),
                  )));
                },
                child: Text('Resend Email')),
            ElevatedButton(
                onPressed: () async {
                  await _auth.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontFamily: "Raleway",
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

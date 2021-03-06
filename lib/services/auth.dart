import 'package:brain_store/services/db_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:flutter/foundation.dart';

class AuthServices with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DbServices _db = DbServices();

  User get getUser => _auth.currentUser;

  Stream<User> get user => _auth.authStateChanges();

  Future<User> emailSignIn(String email, String password) async {
    try {
      dynamic result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User> signUp(String email, String password) async {
    try {
      dynamic result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> updateUser(String photoUrl) async {
    try {
      await _auth.currentUser.updateProfile(photoURL: photoUrl);
      await _db
          .updateDoc('profile', _auth.currentUser.uid, {"avatar": photoUrl});
      return true;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> sendEmailVerificationLink() async {
    try {
      await _auth.currentUser.sendEmailVerification();
      return true;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}

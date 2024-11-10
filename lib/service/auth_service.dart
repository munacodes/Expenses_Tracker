import 'package:expenses_tracker/screens/dashboard.dart';
import 'package:expenses_tracker/service/db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  var db = Db();

  createUser(data, context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );
      await db.addUser(data, context);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return Dashboard();
          },
        ),
      );
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Sign up failed'),
              content: Text(
                e.toString(),
              ),
            );
          });
    }
  }

  loginUser(data, context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Dashboard();
          },
        ),
      );
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Login failed'),
              content: Text(
                e.toString(),
              ),
            );
          });
    }
  }
}

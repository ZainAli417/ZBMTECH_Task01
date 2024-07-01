import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../UI Screens/Dashboard.dart';

class LoginState extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String? _email;
  String? _password;

  String? get email => _email;
  String? get password => _password;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  Future<void> loginUser(BuildContext context) async {
    if (_email == null || _password == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email or Password is empty')),
      );
      return;
    }

    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: _email!, password: _password!);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  DashboardScreen()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to login: ${e.message}')),
      );
    }
  }
}

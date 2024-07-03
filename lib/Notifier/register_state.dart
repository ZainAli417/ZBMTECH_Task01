import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../AUTH/login.dart';

class RegisterState extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _name;
  String? _email;
  String? _password;
  String? _confirmPassword;
  String? _contact;

  // Getters for form values
  String? get name => _name;
  String? get email => _email;
  String? get password => _password;
  String? get confirmPassword => _confirmPassword;
  String? get contact => _contact;

  // Setters for form values
  void setName(String value) {
    _name = value;
    notifyListeners();
  }

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  void setConfirmPassword(String value) {
    _confirmPassword = value;
    notifyListeners();
  }

  void setContact(String value) {
    _contact = value;
    notifyListeners();
  }


  Future<void> registerUser(BuildContext context) async {
    if (!_validateInputFields(context)) {
      return;
    }

    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: _email!,
        password: _password!,
      );

      final userData = {
        'name': _name!,
        'email': _email!,
        'contact': int.parse(_contact!),
      };

      await _firestore.collection('users').doc(userCredential.user?.uid).set(userData);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration Successful')),
      );
    } catch (error) {
      print("Error registering user: $error");

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Registration Failed"),
          content: Text(error.toString()),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );
    }
  }
  bool _validateInputFields(BuildContext context) {
    const emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final emailRegExp = RegExp(emailPattern);

    // Password pattern: at least 8 characters, one uppercase, one lowercase, one digit, one special character
    const passwordPattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
    final passwordRegExp = RegExp(passwordPattern);

    if (!emailRegExp.hasMatch(_email ?? '')) {
      _showError(context, 'Invalid email format');
      return false;
    }

    if (!passwordRegExp.hasMatch(_password ?? '')) {
      _showError(context, 'Password must be at least 8 characters long and include at least one uppercase letter, one lowercase letter, one digit, and one special character');
      return false;
    }

    if (_password != _confirmPassword) {
      _showError(context, 'Passwords do not match');
      return false;
    }

    if (_contact == null || _contact!.length != 11 || !_isNumeric(_contact!)) {
      _showError(context, 'Contact number must be 11 digits');
      return false;
    }

    return true;
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  bool _isNumeric(String str) {
    final numericRegex = RegExp(r'^[0-9]+$');
    return numericRegex.hasMatch(str);
  }
}

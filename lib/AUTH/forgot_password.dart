import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();

    Future<void> _sendPasswordResetEmail(BuildContext context) async {
      String email = _emailController.text;
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        // Show a confirmation dialog to the UI Screens
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Reset Instruction Sent"),
              content: const Text("Check your inbox for reset instructions."),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      } catch (error) {
        // Handle errors here
        print("Error sending password reset email: $error");
        // Show an error message to the UI Screens if email sending fails
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
          titleSpacing: 0.0,
          leading: Row(
            children: [
              SizedBox(
                width: 10.w,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  FeatherIcons.arrowLeft,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ],
          ),
          title: Transform(
            transform: Matrix4.translationValues(-20.0, 0.0, 0.0),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                "Back",
                style: TextStyle(color: Colors.black, fontSize: 12.sp),
              ),
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(
                FeatherIcons.helpCircle,
                color: Colors.black,
                size: 20,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  "Reset password",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 22.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Enter the email associated with your account. We will send you an email with instructions to reset your password.",
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Email Address",
                  style: TextStyle(fontSize: 12.sp),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                      ),
                      color: Colors.grey[100],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'someone@example.com',
                        contentPadding: EdgeInsets.all(10)),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                MaterialButton(
                  color: Theme.of(context).primaryColor,
                  height: 20.h,
                  minWidth: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Theme.of(context).primaryColor)),
                  child: Text(
                    "Send Instruction",
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                  onPressed: () {
                    // Call function to send password reset email
                    _sendPasswordResetEmail(context);
                  },
                ),
                SizedBox(
                  height: 8.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

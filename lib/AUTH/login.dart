import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../Notifier/login_state.dart';
import 'register.dart';
import '../AUTH/forgot_password.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginState = Provider.of<LoginState>(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Welcome To ZBMTech",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.h),
                TextField(
                  onChanged: (value) {
                    loginState.setEmail(value);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Enter Email Here',
                  ),
                ),
                SizedBox(height: 20.h),
                TextField(
                  obscureText: true,
                  onChanged: (value) {
                    loginState.setPassword(value);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Enter Password',
                  ),
                ),
                SizedBox(height: 5.h),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ForgotPassword()),
                    );
                  },
                  child: Text(
                    "Forgot Password ?",
                    style: TextStyle(fontSize: 12.sp, color: Colors.black54),
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        color: Theme.of(context).primaryColor,
                        height: 20.h,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Theme.of(context).primaryColor),
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 20.sp),
                        ),
                        onPressed: () {
                          loginState.loginUser(context);
                        },
                      ),
                    ),
                    SizedBox(width: 10.h),
                    Expanded(
                      child: MaterialButton(
                        color: Colors.white,
                        height: 20.h,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Theme.of(context).primaryColor),
                        ),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20.sp,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const RegisterScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

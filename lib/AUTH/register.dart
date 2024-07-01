import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../Notifier/register_state.dart';
import 'login.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerState = Provider.of<RegisterState>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                Text(
                  "Welcome User",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.sp),
                ),
                Image.asset(
                  "assets/register.jpg",
                  height: 250.h,
                  width: double.infinity,
                ),
                Text("Get Registered From Here", style: TextStyle(fontSize: 12.sp)),
                SizedBox(height: 20.h),
                _buildTextField(
                  label: "Name",
                  hintText: 'Enter Your Name',
                  controller: registerState.setName,
                ),
                SizedBox(height: 20.h),
                _buildTextField(
                  label: "Email",
                  hintText: 'Enter Email',
                  keyboardType: TextInputType.emailAddress,
                  controller: registerState.setEmail,
                ),
                SizedBox(height: 20.h),
                _buildTextField(
                  label: "Password",
                  hintText: 'Enter Password',
                  obscureText: true,
                  controller: registerState.setPassword,
                ),
                SizedBox(height: 20.h),
                _buildTextField(
                  label: "Confirm Password",
                  hintText: 'Confirm Password',
                  obscureText: true,
                  controller: registerState.setConfirmPassword,
                ),
                SizedBox(height: 20.h),
                _buildTextField(
                  label: "Contact",
                  hintText: 'Enter Contact Number',
                  keyboardType: TextInputType.number,
                  controller: registerState.setContact,
                ),

                SizedBox(height: 20.h),
                Center(
                child: MaterialButton(
                  color: Theme.of(context).primaryColor,
                  height: 20.h,
                  minWidth: 220,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  child: Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 20.sp)),
                  onPressed: () {
                    registerState.registerUser(context);
                  },
                ),
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? ", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14.sp, color: Colors.black54)),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
                      },
                      child: Text("Login", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp, color: Theme.of(context).primaryColor)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hintText,
    TextInputType? keyboardType,
    bool obscureText = false,
    required Function(String) controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12.sp)),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            color: Colors.grey[100],
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              contentPadding: EdgeInsets.all(10),
            ),
            keyboardType: keyboardType,
            obscureText: obscureText,
            onChanged: controller,
          ),
        ),
      ],
    );
  }
}

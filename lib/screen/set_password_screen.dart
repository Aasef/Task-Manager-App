import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/service/api_caller.dart';
import 'package:task_manager/screen/forgot_password_emai_varify.dart';
import 'package:task_manager/screen/loginScreen.dart';
import 'package:task_manager/screen/signUpScreen.dart';
import 'package:task_manager/screen_background.dart';

import '../data/url.dart';

class Setpassword extends StatefulWidget {
  const Setpassword({super.key, required this.email, required this.otp});

  final String email;
  final String otp;

  @override
  State<Setpassword> createState() => _SetpasswordState();
}

class _SetpasswordState extends State<Setpassword> {
  final TextEditingController _confirmPasswordTEcontroller =
      TextEditingController();
  final TextEditingController _passwordTEcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 82,
                ),
                Text('Set Your Password',
                    style: Theme.of(context).textTheme.titleLarge),
                Text(
                  'Minimum leangth password 8 character with latter and number combination',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.grey),
                ),
                TextFormField(
                  obscureText: true,
                  controller: _passwordTEcontroller,
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                  validator: (value) {
                    if(value==null||value.isEmpty){
                      return 'Password can not be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _confirmPasswordTEcontroller,
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Confirm Password'),
                  validator: (value) {
                    if(value==null||value.isEmpty){
                      return 'Confirm can not be empty';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                FilledButton(
                    onPressed: _onTapConfirmButton, child: Text('Confirm')),
                Center(
                  child: Column(
                    children: [
                      RichText(
                          text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              text: "Have an account?",
                              children: [
                            TextSpan(
                                text: " Sign In",
                                style: TextStyle(color: Colors.green),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _onTapSignUpButton)
                          ]))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Future<void> _apiCallForSetPassword() async {
    if (_confirmPasswordTEcontroller.text == _passwordTEcontroller.text) {
      Map<String, dynamic> requestBody = {
        'email': widget.email,
        'OTP': widget.otp,
        'password': _confirmPasswordTEcontroller.text
      };
      final ApiResponse response = await ApiCaller.postResponse(
          url: Urls.resetPassword, body: requestBody);
      if (response.isSucess) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
            (predicate) => false);
      }else{
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed to reset password')));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Password not matched')));
    }
  }

  void _onTapSignUpButton() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Signupscreen(),
        ));
  }

  void _onTapConfirmButton() {
    if(_formKey.currentState!.validate()){
      _apiCallForSetPassword();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _confirmPasswordTEcontroller.dispose();
    _passwordTEcontroller.dispose();
  }
}

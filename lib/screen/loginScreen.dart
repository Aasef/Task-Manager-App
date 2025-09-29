import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/screen/forgot_password_emai_varify.dart';
import 'package:task_manager/screen/signUpScreen.dart';
import 'package:task_manager/screen_background.dart';

import 'mainScreenAfterLogin.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEcontroller = TextEditingController();
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
                Text('Get Started With',
                    style: Theme.of(context).textTheme.titleLarge),
                TextFormField(
                  controller: _emailTEcontroller,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _passwordTEcontroller,
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Password'),
                ),
                SizedBox(
                  height: 10,
                ),
                FilledButton(
                    onPressed: _onTapLoginButton,
                    child: Icon(
                      Icons.arrow_circle_right_outlined,
                    )),
                Center(
                  child: Column(
                    children: [
                      TextButton(
                          onPressed: _onPressForgotPassword,
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.grey),
                          )),
                      RichText(
                          text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              text: "Don't have account?",
                              children: [
                            TextSpan(
                                text: " Sign Up",
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

  void _onTapLoginButton() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreenAfterLogin(),
      ),
      (padicate) => false,
    );
  }

  void _onTapSignUpButton() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Signupscreen(),
        ));
  }

  void _onPressForgotPassword() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmailVerify(),
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTEcontroller.dispose();
    _passwordTEcontroller.dispose();
  }
}

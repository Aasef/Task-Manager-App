import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/screen/forgot_password_emai_varify.dart';
import 'package:task_manager/screen/loginScreen.dart';
import 'package:task_manager/screen/signUpScreen.dart';
import 'package:task_manager/screen_background.dart';

class Setpassword extends StatefulWidget {
  const Setpassword({super.key});

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
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _confirmPasswordTEcontroller,
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Confirm Password'),
                ),
                SizedBox(
                  height: 10,
                ),
                FilledButton(onPressed:_onTapConfirmButton, child: Text('Confirm')),
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

  void _onTapSignUpButton() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
  }

  void _onTapConfirmButton() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      (pedicate)=> false
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _confirmPasswordTEcontroller.dispose();
    _passwordTEcontroller.dispose();
  }
}

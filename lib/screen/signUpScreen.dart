import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/service/api_caller.dart';

import '../data/url.dart';
import '../screen_background.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  final TextEditingController _emailTEcontroller = TextEditingController();
  final TextEditingController _passwordTEcontroller = TextEditingController();
  final TextEditingController _firstNameTEcontroller = TextEditingController();
  final TextEditingController _lastNameTEcontroller = TextEditingController();
  final TextEditingController _mobileTEcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool signUpProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 82,
                ),
                Text('Join With Us',
                    style: Theme.of(context).textTheme.titleLarge),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _firstNameTEcontroller,
                  decoration: InputDecoration(hintText: 'First Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please write first name";
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _lastNameTEcontroller,
                  decoration: InputDecoration(
                    hintText: 'Last Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please write Last Name";
                    }
                    return null;
                  },
                ),
                TextFormField(
                    controller: _emailTEcontroller,
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please write valid email";
                      }
                    }),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                    controller: _mobileTEcontroller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Mobile',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please write mobile number";
                      }
                    }),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                    controller: _passwordTEcontroller,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please write password ";
                      }
                    }),
                SizedBox(
                  height: 5,
                ),
                Visibility(
                  visible: signUpProgress == false,
                  replacement: CircularProgressIndicator(),
                  child: FilledButton(
                      onPressed: _onTabRegisterButton,
                      child: Icon(
                        Icons.arrow_circle_right_outlined,
                      )),
                ),
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      RichText(
                          text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              text: "Have account?",
                              children: [
                            TextSpan(
                                text: " Sign In",
                                style: TextStyle(color: Colors.green),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _onTapSignInButton)
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

  void _onTabRegisterButton() {
    if (_formKey.currentState!.validate()) {
      //TODO:
      _apiCallForSignUp();
    }
  }

  Future<void> _apiCallForSignUp() async {
    signUpProgress = true;
    setState(() {});
    Map<String, dynamic> takingValueForSignUp = {
      "email": _emailTEcontroller.text,
      "firstName": _firstNameTEcontroller.text,
      "lastName": _lastNameTEcontroller.text,
      "mobile": _mobileTEcontroller.text,
      "password": _passwordTEcontroller.text,
    };
    final ApiResponse response = await ApiCaller.postResponse(
        url: Urls.signUpUrl, body: takingValueForSignUp);
    signUpProgress = false;
    setState(() {});
    if (response.isSucess) {
      _clearFieldText();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("SignUp Successfully")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.responseData)));
    }
  }

  void _onTapSignInButton() {
    Navigator.pop(context);
  }

  void _clearFieldText() {
    _firstNameTEcontroller.clear();
    _lastNameTEcontroller.clear();
    _emailTEcontroller.clear();
    _mobileTEcontroller.clear();
    _passwordTEcontroller.clear();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTEcontroller.dispose();
    _passwordTEcontroller.dispose();
    _firstNameTEcontroller.dispose();
    _lastNameTEcontroller.dispose();
    _mobileTEcontroller.dispose();
  }
}

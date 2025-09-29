import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
                    Text(
                        'Join With Us',
                        style: Theme.of(context).textTheme.titleLarge
                    ),
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
                      controller:_firstNameTEcontroller,
            
                      decoration: InputDecoration(hintText: 'First Name'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _lastNameTEcontroller,
                      decoration: InputDecoration(
                        hintText: 'Last Name',
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: _mobileTEcontroller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Mobile',
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: _passwordTEcontroller,
                      obscureText: true,
                      decoration: InputDecoration(
            
                        hintText: 'Password',
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    FilledButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.arrow_circle_right_outlined,
                        )),
                    Center(
                      child: Column(
                        children: [
                          SizedBox(height: 20,),
                          RichText(
                              text: TextSpan(
                                  style: TextStyle(color: Colors.black),
                                  text: "Have account?",
                                  children: [
                                    TextSpan(
                                        text: " Sign In",
                                        style: TextStyle(color: Colors.green),
                                        recognizer: TapGestureRecognizer()..onTap = _onTapSignIpButton)
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
  void _onTapSignIpButton() {
    Navigator.pop(context);
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

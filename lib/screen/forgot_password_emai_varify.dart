import 'package:email_otp/email_otp.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/service/api_caller.dart';
import 'package:task_manager/screen/loginScreen.dart';
import 'package:task_manager/screen/pin_verify_screen.dart';
import 'package:task_manager/screen/signUpScreen.dart';
import 'package:task_manager/screen_background.dart';

import '../data/url.dart';
//import 'package:email_otp/email_otp.dart';

class EmailVerify extends StatefulWidget {
  const EmailVerify({super.key});

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
  final TextEditingController _emailTEcontroller = TextEditingController();

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
                Text('Your Email Address',
                    style: Theme.of(context).textTheme.titleLarge),
                Text(
                  'A 6 digit verification pin will send to your email',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.grey),
                ),
                TextFormField(
                  controller: _emailTEcontroller,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                  validator: (value) {
                    if(value==null || value.isEmpty){
                      return 'Please enter a valid email';
                    }
                    return null;
                  },

                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 10,
                ),
                FilledButton(
                    onPressed: _onTabEmailVerifyButton,
                    child: Icon(
                      Icons.arrow_circle_right_outlined,
                    )),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Column(
                    children: [
                      RichText(
                          text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              text: "Have account?",
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
  Future<void> _sendingOTP()async{
    Map<String,dynamic> requestBody={
      "email":_emailTEcontroller.text
    };
    final ApiResponse response = await ApiCaller.getResponse(
        url: Urls.emailVerify(requestBody['email']));
    if(response.isSucess){
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('OTP has been sent')));
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Pinverify(gettingEmail: _emailTEcontroller.text,),
          ));
    }else{
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.errorMessage!)));
    }
  }
  // void _sendingOTP()async{
  //   await EmailOTP.sendOTP(email: _emailTEcontroller.text);
  // }
  void _onTabEmailVerifyButton() {
    if(_formKey.currentState!.validate()){
       _sendingOTP();

    }

  }

  void _onTapSignUpButton() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTEcontroller.dispose();
  }
}

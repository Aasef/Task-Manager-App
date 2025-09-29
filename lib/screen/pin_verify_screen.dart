import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/screen/loginScreen.dart';
import 'package:task_manager/screen/set_password_screen.dart';
import 'package:task_manager/screen/signUpScreen.dart';
import 'package:task_manager/screen_background.dart';

class Pinverify extends StatefulWidget {
  const Pinverify({super.key});

  @override
  State<Pinverify> createState() => _PinverifyState();
}

class _PinverifyState extends State<Pinverify> {
  final TextEditingController _pinTEcontroller = TextEditingController();

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
                Text('Enter Your Pin',
                    style: Theme.of(context).textTheme.titleLarge),
                Text(
                  'A 6 digit verification pin has been sent to your email',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.grey),
                ),
                PinCodeTextField(
                  length: 6,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: false,
                  //errorAnimationController: errorController,
                  controller: _pinTEcontroller,
                  appContext: context,
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 10,
                ),
                FilledButton(onPressed: _onTapVerifyButton, child: Text('Verify')),
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

  void _onTapVerifyButton() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Setpassword(),
        ));
  }

  void _onTapSignUpButton() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),

        ),
            (protecte)=> false
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pinTEcontroller.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/screen/mainScreenAfterLogin.dart';
import 'package:task_manager/screen_background.dart';
import 'package:task_manager/ui/controller/auth_controller.dart';
import 'package:task_manager/utility/assetpath.dart';

import 'loginScreen.dart';

class Splash_screen extends StatefulWidget {
  const Splash_screen({super.key});

  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    final bool isLoggedIn = await AuthController.isUserLoggedIn();
    if (isLoggedIn) {
      await AuthController.getUserData();
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreenAfterLogin(),
          ));
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
          (predicate) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Stack(
          children: [Center(child: SvgPicture.asset(AssetPath.logoSvg))],
        ),
      ),
    );
  }
}

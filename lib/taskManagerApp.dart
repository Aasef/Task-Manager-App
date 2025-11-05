import 'package:flutter/material.dart';
import 'package:task_manager/screen/splash_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});
  static GlobalKey<NavigatorState> navigator=GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigator,
      theme: ThemeData(

          textTheme: TextTheme(
              titleLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
              ),
          inputDecorationTheme: InputDecorationTheme(
              fillColor: Colors.white,
              filled: true,
              contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 5),
              border: OutlineInputBorder(borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
              errorBorder: OutlineInputBorder(borderSide: BorderSide.none)),
          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                fixedSize: Size.fromWidth(double.maxFinite)),
          )),
      home: Splash_screen(),
    );
  }
}

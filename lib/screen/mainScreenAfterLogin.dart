import 'package:flutter/material.dart';
import 'package:task_manager/screen/newTaskScreen.dart';
import 'package:task_manager/screen/progressTaskScreen.dart';

import '../widgets/appBarDesign.dart';
import 'cancelledTaskScreen.dart';
import 'completedTaskScreen.dart';

class MainScreenAfterLogin extends StatefulWidget {
  const MainScreenAfterLogin({super.key});

  @override
  State<MainScreenAfterLogin> createState() => _MainScreenAfterLoginState();
}

class _MainScreenAfterLoginState extends State<MainScreenAfterLogin> {
  int _selecTedIndex = 0;
  final List<Widget> _screen = [
    Newtaskscreen(),
    Progresstaskscreen(),
    Completedtaskscreen(),
    Cancelledtaskscreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign(),
      body: _screen[_selecTedIndex],
      bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.green,
          selectedIndex: _selecTedIndex,
          onDestinationSelected: (int index) {
            _selecTedIndex = index;
            setState(() {});
          },
          destinations: [
            NavigationDestination(icon: Icon(Icons.new_label), label: 'New'),
            NavigationDestination(
                icon: Icon(Icons.downloading), label: 'Progress'),
            NavigationDestination(icon: Icon(Icons.done), label: 'Completed'),
            NavigationDestination(icon: Icon(Icons.cancel), label: 'Cancelled')
          ]),
    );
  }
}


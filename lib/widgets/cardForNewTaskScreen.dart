import 'package:flutter/material.dart';
class CardForNewTaskScreen extends StatelessWidget {



  final int count;
  final String title;
  const CardForNewTaskScreen({
    super.key, required this.count, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 15),
        child: Column(
          children: [
            Text('$count', style: Theme.of(context).textTheme.titleLarge,),
            Text('$title')
          ],
        ),
      ),
    );
  }
}
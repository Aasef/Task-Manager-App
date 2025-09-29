import 'package:flutter/material.dart';
import 'package:task_manager/screen_background.dart';
import 'package:task_manager/widgets/appBarDesign.dart';
class Addnewtask extends StatefulWidget {
  const Addnewtask({super.key});

  @override
  State<Addnewtask> createState() => _AddnewtaskState();
}

class _AddnewtaskState extends State<Addnewtask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign(),
        body: ScreenBackground(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 32,),
                Text('Add New Text', style: Theme.of(context).textTheme.titleLarge,),
                SizedBox(height: 10,),
                TextFormField(
                   textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Title'
                  ),
          
                ),
                SizedBox(height: 10,),
                TextFormField(
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: 'Description'
                  ),
                ),
                SizedBox(height: 10,),
                FilledButton(onPressed: (){}, child: Text('Add'))
              ],
            ),
          ),
        ),
    );
  }
}

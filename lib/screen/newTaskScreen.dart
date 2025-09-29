import 'package:flutter/material.dart';
import 'package:task_manager/screen/addNewTask.dart';

import '../widgets/cardForNewTaskScreen.dart';

class Newtaskscreen extends StatefulWidget {
  const Newtaskscreen({super.key});

  @override
  State<Newtaskscreen> createState() => _NewtaskscreenState();
}

class _NewtaskscreenState extends State<Newtaskscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: _addNewTaskButton,child: Icon(Icons.add),),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: SizedBox(
              height: 100,
              child: ListView.separated(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CardForNewTaskScreen(count: 2, title: 'new');
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 8,
                  );
                },
              ),
            ),
          ),
          Expanded(
              child: ListView.separated(

                  itemBuilder: (context, index) {
                    return ListTile(
                      shape: RoundedRectangleBorder( borderRadius: BorderRadiusGeometry.circular(10)),
                       tileColor: Colors.white,
                      title: Text('Text Will be Here'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text('Description'),
                          Text('Date: 20/09/2025'),
                          Row(
                            children: [
                             Chip(

                                 label: Text('New', style: TextStyle(color: Colors.white),),
                                backgroundColor: Colors.blueAccent,
                               padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
                               shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(20)),


                             ),
                              Spacer(),
                              IconButton(onPressed: (){}, icon: Icon(Icons.update, color: Colors.green,)),
                              IconButton(onPressed: (){}, icon: Icon(Icons.delete, color: Colors.red,))
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: 3))
        ],
      ),
    );
  }
  void _addNewTaskButton(){

   Navigator.push(context, MaterialPageRoute(builder: (context) => Addnewtask(),));
  }
}

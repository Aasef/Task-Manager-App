import 'package:flutter/material.dart';

import '../widgets/cardForNewTaskScreen.dart';

class Cancelledtaskscreen extends StatefulWidget {
  const Cancelledtaskscreen({super.key});

  @override
  State<Cancelledtaskscreen> createState() => _CancelledtaskscreenState();
}

class _CancelledtaskscreenState extends State<Cancelledtaskscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

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

                                label: Text('Cancelled', style: TextStyle(color: Colors.white),),
                                backgroundColor: Colors.red,
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
}

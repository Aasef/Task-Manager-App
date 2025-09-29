import 'package:flutter/material.dart';
import 'package:task_manager/screen/update_profile_screen.dart';
class AppBarDesign extends StatelessWidget implements PreferredSizeWidget{
  const AppBarDesign({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    void _onTapProfile(){
      Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProfileScreen(),));
    }
    return GestureDetector(
      onTap: () {
        _onTapProfile();
      },
      child: AppBar(
        backgroundColor: Colors.green,
        title:  Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            spacing: 10,
            children: [
              CircleAvatar(

              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Your Name',style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white
                  )),
                  Text('email@gmail.com',style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white
                  ))
                ],

              )
            ],
          ),
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.logout,color: Colors.white,))
        ],
      ),
    );


  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(56);



}

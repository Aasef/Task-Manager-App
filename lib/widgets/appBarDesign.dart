import 'package:flutter/material.dart';
import 'package:task_manager/screen/loginScreen.dart';
import 'package:task_manager/screen/update_profile_screen.dart';
import 'package:task_manager/ui/controller/auth_controller.dart';

class AppBarDesign extends StatefulWidget implements PreferredSizeWidget {
  const AppBarDesign({
    super.key,
    this.fromUpdateProfile,
  });

  final bool? fromUpdateProfile;

  @override
  State<AppBarDesign> createState() => _AppBarDesignState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _AppBarDesignState extends State<AppBarDesign> {
  @override
  Widget build(BuildContext context) {
    void _onTapProfile() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UpdateProfileScreen(),
          ));
    }

    return GestureDetector(
      onTap: () {
        if (widget.fromUpdateProfile ?? false) {
          return;
        }
        _onTapProfile();
      },
      child: AppBar(
        backgroundColor: Colors.green,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            spacing: 10,
            children: [
              CircleAvatar(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( AuthController.userModel?.fullName ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Colors.white)),
                  Text(AuthController.userModel?.email ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.white))
                ],
              )
            ],
          ),
        ),
        actions: [
          IconButton(
              onPressed: _signOut,
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
    );
  }

  Future<void> _signOut() async {
    AuthController.clearData();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
        (predicate) => false);
  }
}

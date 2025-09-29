import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/screen_background.dart';
import 'package:task_manager/widgets/appBarDesign.dart';

import '../widgets/photo_picker.dart';
class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTEcontroller = TextEditingController();
  final TextEditingController _passwordTEcontroller = TextEditingController();
  final TextEditingController _firstNameTEcontroller = TextEditingController();
  final TextEditingController _lastNameTEcontroller = TextEditingController();
  final TextEditingController _mobileTEcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ImagePicker imagePicker=ImagePicker();
  XFile? _selectedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30,),
                  Text('Update Profile', style: Theme.of(context).textTheme.titleLarge,),
                  SizedBox(height: 10,),
                  PhotoPicker(onTap: upLoadImage,
                    selectedPhoto: _selectedImage,
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: _emailTEcontroller,
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller:_firstNameTEcontroller,
          
                    decoration: InputDecoration(hintText: 'First Name'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _lastNameTEcontroller,
                    decoration: InputDecoration(
                      hintText: 'Last Name',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _mobileTEcontroller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Mobile',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _passwordTEcontroller,
                    obscureText: true,
                    decoration: InputDecoration(
          
                      hintText: 'Password',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FilledButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.arrow_circle_right_outlined,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> upLoadImage()async{
    XFile? pickedImage= await imagePicker.pickImage(source: ImageSource.gallery);
    if(pickedImage!=null){
      _selectedImage=pickedImage;
      setState(() {

      });
    }
  }
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTEcontroller.dispose();
    _passwordTEcontroller.dispose();
    _firstNameTEcontroller.dispose();
    _lastNameTEcontroller.dispose();
    _mobileTEcontroller.dispose();
  }
}



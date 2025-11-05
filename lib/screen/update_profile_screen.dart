import 'dart:convert';
import 'dart:ffi';
//import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/model/user_model.dart';
import 'package:task_manager/data/service/api_caller.dart';
import 'package:task_manager/screen_background.dart';
import 'package:task_manager/ui/controller/auth_controller.dart';
import 'package:task_manager/widgets/appBarDesign.dart';

import '../data/url.dart';
import '../widgets/photo_picker.dart';
class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  bool updateProfileInProgress= false;
  final TextEditingController _emailTEcontroller = TextEditingController();
  final TextEditingController _passwordTEcontroller = TextEditingController();
  final TextEditingController _firstNameTEcontroller = TextEditingController();
  final TextEditingController _lastNameTEcontroller = TextEditingController();
  final TextEditingController _mobileTEcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ImagePicker imagePicker=ImagePicker();
  XFile? _selectedImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserModel user= AuthController.userModel!;
    _emailTEcontroller.text=user.email;
    _firstNameTEcontroller.text=user.firstName;
    _lastNameTEcontroller.text=user.lastName;
    _mobileTEcontroller.text=user.mobile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign(fromUpdateProfile: true,),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      enabled: false,

                    ),
                    validator: (value) {
                      if(value==null || value.isEmpty){
                        return 'Please enter some texts';
                      }
                      return null;
                    },

                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller:_firstNameTEcontroller,
          
                    decoration: InputDecoration(hintText: 'First Name'),
                    validator: (value) {
                      if(value==null || value.isEmpty){
                        return 'Please enter some texts';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _lastNameTEcontroller,
                    decoration: InputDecoration(
                      hintText: 'Last Name',
                    ),
                    validator: (value) {
                      if(value==null || value.isEmpty){
                        return 'Please enter some texts';
                      }
                      return null;
                    },
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
                    validator: (value) {
                      if(value==null || value.isEmpty){
                        return 'Please enter some texts';
                      }
                      return null;
                    },
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
                    validator: (value) {
                      if(value==null || value.isEmpty){
                        return 'Please enter some texts';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: updateProfileInProgress==false,
                    replacement: Center(child: CircularProgressIndicator(),),
                    child: FilledButton(
                        onPressed:_updateButton,
                        child: Icon(
                          Icons.arrow_circle_right_outlined,
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _updateButton(){
    if(_formKey.currentState!.validate()){
      _updateProfile();
    }
  }
  Future<void> _updateProfile() async{
    updateProfileInProgress==true;
    setState(() {});
    final Map<String, dynamic> requestBody={
      "email": _emailTEcontroller.text,
      "firstName":_firstNameTEcontroller.text,
      "lastName":_lastNameTEcontroller.text,
      "mobile":_mobileTEcontroller.text,

    };
    if (_passwordTEcontroller.text.isNotEmpty){
      requestBody["password"]=_passwordTEcontroller.text;
    }
    if(_selectedImage!=null ){
      Uint8List byte =  await _selectedImage!.readAsBytes();
      requestBody["photo"] =jsonEncode(byte);
    }
    final ApiResponse response= await ApiCaller.postResponse(url: Urls.updateProfile, body: requestBody);
    updateProfileInProgress==false;
    setState(() {});
    if(response.isSucess){
      _passwordTEcontroller.clear();
      UserModel model =UserModel(id: AuthController.userModel!.id,
          firstName: _firstNameTEcontroller.text,
          lastName: _lastNameTEcontroller.text,
          email: _emailTEcontroller.text, mobile: _mobileTEcontroller.text);
      await AuthController.updateUserData(model);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Profile has been updated")));

    }else{
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.errorMessage!)));
    }
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



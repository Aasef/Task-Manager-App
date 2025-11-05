import 'package:flutter/material.dart';
import 'package:task_manager/data/service/api_caller.dart';
import 'package:task_manager/data/url.dart';
import 'package:task_manager/screen_background.dart';
import 'package:task_manager/widgets/appBarDesign.dart';

class Addnewtask extends StatefulWidget {
  const Addnewtask({super.key});

  @override
  State<Addnewtask> createState() => _AddnewtaskState();
}

class _AddnewtaskState extends State<Addnewtask> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool adNewTaskInProgress = false;

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
              SizedBox(
                height: 32,
              ),
              Text(
                'Add New Text',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: 10,
              ),
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _titleController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(hintText: 'Title'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter title';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 6,
                      decoration: InputDecoration(hintText: 'Description'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter description';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Visibility(
                        visible: adNewTaskInProgress == false,
                        replacement: CircularProgressIndicator(),
                        child:
                            FilledButton(onPressed: _onTapAddButton, child: Text('Add')))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
  void _onTapAddButton(){
    if(_formKey.currentState!=null){
        _apiCallforAddNewTask();
    }

  }
  Future<void> _apiCallforAddNewTask()async{
    adNewTaskInProgress=true;
    setState(() {

    });
    Map<String,dynamic> requestBody={
      "title":_titleController.text,
      "description": _descriptionController.text,
      "status":"New"
    };
    final ApiResponse response=await ApiCaller.postResponse(url: Urls.addNewTaskUrl, body: requestBody);
    adNewTaskInProgress=false;
    setState(() {

    });
    if(response.isSucess){
    _clear();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Success')));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Not Success')));
    }

  }
  void _clear(){
    _titleController.clear();
    _descriptionController.clear();
  }
 @override
  void dispose() {
    // TODO: implement dispose
   _titleController.dispose();
   _descriptionController.dispose();
    super.dispose();
  }
}

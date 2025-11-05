import 'package:flutter/material.dart';

import '../data/model/task_model.dart';
import '../data/model/task_status_count_model.dart';
import '../data/service/api_caller.dart';
import '../data/url.dart';
import '../widgets/cardForNewTaskScreen.dart';
import 'newTaskScreen.dart';

class Progresstaskscreen extends StatefulWidget {
  const Progresstaskscreen({super.key});

  @override
  State<Progresstaskscreen> createState() => _ProgresstaskscreenState();
}

class _ProgresstaskscreenState extends State<Progresstaskscreen> {

  bool _getProgressTaskInProgress = false;
  List<TaskStatusCountModel> _taskStatusCountList = [];
  List<TaskModel> _progressTaskStatusList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProgressTask();
  }


  Future<void> _getProgressTask() async {
    //_getTaskStatusCountProgress = true;
    _getProgressTaskInProgress = true;
    setState(() {});
    final ApiResponse response =
    await ApiCaller.getResponse(url: Urls.taskByStatusProgress);
    if (response.isSucess) {
      List<TaskModel> newList = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        newList.add(TaskModel.fromJson(jsonData));
      }
      _progressTaskStatusList = newList;
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.errorMessage!)));
    }
    _getProgressTaskInProgress = false;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          // Expanded(
          //     child: ListView.separated(
          //
          //         itemBuilder: (context, index) {
          //           return ListTile(
          //             shape: RoundedRectangleBorder( borderRadius: BorderRadiusGeometry.circular(10)),
          //             tileColor: Colors.white,
          //             title: Text('Text Will be Here'),
          //             subtitle: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //
          //                 Text('Description'),
          //                 Text('Date: 20/09/2025'),
          //                 Row(
          //                   children: [
          //                     Chip(
          //
          //                       label: Text('Progress', style: TextStyle(color: Colors.white),),
          //                       backgroundColor: Colors.purple,
          //                       padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
          //                       shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(20)),
          //
          //
          //                     ),
          //                     Spacer(),
          //                     IconButton(onPressed: (){}, icon: Icon(Icons.update, color: Colors.green,)),
          //                     IconButton(onPressed: (){}, icon: Icon(Icons.delete, color: Colors.red,))
          //                   ],
          //                 )
          //               ],
          //             ),
          //           );
          //         },
          //         separatorBuilder: (context, index) {
          //           return SizedBox(
          //             height: 10,
          //           );
          //         },
          //         itemCount: 3)),
          Expanded(
              child: Visibility(
                visible: _getProgressTaskInProgress == false,
                replacement: Center(child: CircularProgressIndicator()),
                child: ListView.separated(
                  itemCount: _progressTaskStatusList.length,
                  itemBuilder: (context, index) {
                    return NewTaskList(
                      taskModel: _progressTaskStatusList[index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                ),
              ))
        ],
      ),
    );
  }
}

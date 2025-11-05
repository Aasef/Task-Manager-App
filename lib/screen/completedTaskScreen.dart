import 'package:flutter/material.dart';

import '../data/model/task_model.dart';
import '../data/model/task_status_count_model.dart';
import '../data/service/api_caller.dart';
import '../data/url.dart';
import '../widgets/cardForNewTaskScreen.dart';
import 'newTaskScreen.dart';

class Completedtaskscreen extends StatefulWidget {
  const Completedtaskscreen({super.key});

  @override
  State<Completedtaskscreen> createState() => _CompletedtaskscreenState();
}

class _CompletedtaskscreenState extends State<Completedtaskscreen> {

  bool _getCompletedTaskInProgress = false;
  List<TaskStatusCountModel> _taskStatusCountList = [];
  List<TaskModel> _completedTaskStatusList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCompletedTask();
  }



  Future<void> _getCompletedTask() async {
    //_getTaskStatusCountProgress = true;
    _getCompletedTaskInProgress = true;
    setState(() {});
    final ApiResponse response =
    await ApiCaller.getResponse(url: Urls.taskByStatusCompleted);
    if (response.isSucess) {
      List<TaskModel> newList = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        newList.add(TaskModel.fromJson(jsonData));
      }
      _completedTaskStatusList = newList;
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.errorMessage!)));
    }
    _getCompletedTaskInProgress = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [


          Expanded(
              child: Visibility(
                visible: _getCompletedTaskInProgress == false,
                replacement: Center(child: CircularProgressIndicator()),
                child: ListView.separated(
                  itemCount: _completedTaskStatusList.length,
                  itemBuilder: (context, index) {
                    return NewTaskList(
                      taskModel: _completedTaskStatusList[index],
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



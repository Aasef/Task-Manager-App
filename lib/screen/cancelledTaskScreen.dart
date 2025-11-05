import 'package:flutter/material.dart';

import '../data/model/task_model.dart';
import '../data/model/task_status_count_model.dart';
import '../data/service/api_caller.dart';
import '../data/url.dart';
import '../widgets/cardForNewTaskScreen.dart';
import 'newTaskScreen.dart';

class Cancelledtaskscreen extends StatefulWidget {
  const Cancelledtaskscreen({super.key});

  @override
  State<Cancelledtaskscreen> createState() => _CancelledtaskscreenState();
}

class _CancelledtaskscreenState extends State<Cancelledtaskscreen> {


  bool _getCancelledTaskInProgress = false;
  List<TaskStatusCountModel> _taskStatusCountList = [];
  List<TaskModel> _cancelledTaskStatusList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCancelledTask();
  }



  Future<void> _getCancelledTask() async {
    //_getTaskStatusCountProgress = true;
    _getCancelledTaskInProgress = true;
    setState(() {});
    final ApiResponse response =
    await ApiCaller.getResponse(url: Urls.taskByStatusCancelled);
    if (response.isSucess) {
      List<TaskModel> newList = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        newList.add(TaskModel.fromJson(jsonData));
      }
      _cancelledTaskStatusList = newList;
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.errorMessage!)));
    }
    _getCancelledTaskInProgress = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [


          Expanded(
              child: Visibility(
                visible: _getCancelledTaskInProgress == false,
                replacement: Center(child: CircularProgressIndicator()),
                child: ListView.separated(
                  itemCount: _cancelledTaskStatusList.length,
                  itemBuilder: (context, index) {
                    return NewTaskList(
                      taskModel: _cancelledTaskStatusList[index],
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


import 'package:flutter/material.dart';
import 'package:task_manager/data/model/task_model.dart';
import 'package:task_manager/data/model/task_status_count_model.dart';
import 'package:task_manager/data/service/api_caller.dart';
import 'package:task_manager/data/url.dart';
import 'package:task_manager/screen/addNewTask.dart';

import '../widgets/cardForNewTaskScreen.dart';

class Newtaskscreen extends StatefulWidget {
  const Newtaskscreen({super.key});

  @override
  State<Newtaskscreen> createState() => _NewtaskscreenState();
}

class _NewtaskscreenState extends State<Newtaskscreen> {
  bool _getTaskStatusCountProgress = false;
  bool _getNewTaskInProgress = false;
  List<TaskStatusCountModel> _taskStatusCountList = [];
  List<TaskModel> _newTaskStatusList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTaskStatusCount();
    _getAllTask();
  }

  Future<void> _getTaskStatusCount() async {
    _getTaskStatusCountProgress = true;
    setState(() {});
    final ApiResponse response =
        await ApiCaller.getResponse(url: Urls.taskStatusCount);
    if (response.isSucess) {
      List<TaskStatusCountModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskStatusCountModel.fromjson(jsonData));
      }
      _taskStatusCountList = list;
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.errorMessage!)));
    }
    _getTaskStatusCountProgress = false;
    setState(() {});
  }

  Future<void> _getAllTask() async {
    //_getTaskStatusCountProgress = true;
    _getNewTaskInProgress = true;
    setState(() {});
    final ApiResponse response =
        await ApiCaller.getResponse(url: Urls.taskByStatusNew);
    if (response.isSucess) {
      List<TaskModel> newList = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        newList.add(TaskModel.fromJson(jsonData));
      }
      _newTaskStatusList = newList;
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.errorMessage!)));
    }
    _getNewTaskInProgress = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewTaskButton,
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: SizedBox(
              height: 100,
              child: Visibility(
                visible: _getTaskStatusCountProgress == false,
                replacement: Center(child: CircularProgressIndicator()),
                child: ListView.separated(
                  itemCount: _taskStatusCountList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CardForNewTaskScreen(
                        count: _taskStatusCountList[index].count,
                        title: _taskStatusCountList[index].status);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 8,
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
              child: Visibility(
            visible: _getNewTaskInProgress == false,
            replacement: Center(child: CircularProgressIndicator()),
            child: ListView.separated(
              itemCount: _newTaskStatusList.length,
              itemBuilder: (context, index) {
                return NewTaskList(
                  taskModel: _newTaskStatusList[index],
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

  void _addNewTaskButton() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Addnewtask(),
        ));
  }
}

class NewTaskList extends StatefulWidget {
  const NewTaskList({
    super.key,
    required this.taskModel,
  });

  final TaskModel taskModel;

  @override
  State<NewTaskList> createState() => _NewTaskListState();
}

class _NewTaskListState extends State<NewTaskList> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10)),
      tileColor: Colors.white,
      title: Text(widget.taskModel.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.taskModel.description),
          Text(widget.taskModel.createdDate),
          Row(
            children: [
              Chip(
                label: Text(
                  widget.taskModel.status,
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(20)),
              ),
              Spacer(),
              IconButton(
                  onPressed: _shoChangeStatusDialog,
                  icon: Icon(
                    Icons.update,
                    color: Colors.green,
                  )),
              IconButton(
                  onPressed:() {
                    _deleteStatus();
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ))
            ],
          )
        ],
      ),
    );

  }

  void _shoChangeStatusDialog(){
    showDialog(context: context, builder: (ctx){
      return AlertDialog(
        title: Text('Change Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: (){
                _changeStatus('New');
              },
              title: Text('New'),
              trailing: widget.taskModel.status == 'New'
                      ? Icon(Icons.done)
                      : null,
                ),
            ListTile(
              onTap: (){
                _changeStatus('Progress');
              },
              title: Text('Progress'),
              trailing: widget.taskModel.status == 'Progress'
                  ? Icon(Icons.done)
                  : null,
            ),
            ListTile(
              onTap: (){
                _changeStatus('Completed');
              },
              title: Text('Completed'),
              trailing: widget.taskModel.status == 'Completed'
                  ? Icon(Icons.done)
                  : null,
            ),
            ListTile(
              onTap: (){
                _changeStatus('Cancelled');
              },
              title: Text('Cancelled'),
              trailing: widget.taskModel.status == 'Cancelled'
                  ? Icon(Icons.done)
                  : null,
            ),
          ],
        ),
      );
    });
  }
  Future<void> _changeStatus(String status) async{
    if(status==widget.taskModel.status){
      return;
    }
    ApiResponse response = await ApiCaller.getResponse(
        url: Urls.updateTaskStatus(widget.taskModel.id, status));
    if(response.isSucess){

    }
    else{
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.errorMessage!)));
    }
  }
  Future<void> _deleteStatus() async{

    ApiResponse response = await ApiCaller.getResponse(
        url: Urls.deleteTaskStatus(widget.taskModel.id));
    if(response.isSucess){

    }
    else{
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.errorMessage!)));
    }
  }

}

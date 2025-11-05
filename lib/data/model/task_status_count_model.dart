class TaskStatusCountModel{

  final String status;
  final int count;

  TaskStatusCountModel({required this.status, required this.count});

  factory TaskStatusCountModel.fromjson(Map<String, dynamic> jsonBody) {
    return TaskStatusCountModel(
        status: jsonBody['_id'], count: jsonBody['sum']);
  }
}
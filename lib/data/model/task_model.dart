class TaskModel {
  final String id;
  final String title;
  final String description;
  final String status;
  final String createdDate;

  TaskModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.status,
      required this.createdDate});

  factory TaskModel.fromJson(Map<String, dynamic> jsonData) {
    return TaskModel(
        id: jsonData['_id'],
        title: jsonData['title'],
        description: jsonData['description'],
        status: jsonData['status'],
        createdDate: jsonData['createdDate']);
  }
}
// "title": "A",
// "description": "v",
// "status": "New",
// "email": "ase@gmail.com",
// "createdDate": "2025-10-02T06:21:45.327Z",
// "_id": "68f62bc4880cc5d30a2faf7f"
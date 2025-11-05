class Urls {
  static const String _baseUrl = "http://35.73.30.144:2005/api/v1";
  static const String signUpUrl = '$_baseUrl/Registration';
  static const String loginUrl = '$_baseUrl/Login';
  static const String addNewTaskUrl = '$_baseUrl/createTask';
  static const String taskStatusCount = '$_baseUrl/taskStatusCount';
  static const String taskByStatusNew = '$_baseUrl/listTaskByStatus/New';
  static const String taskByStatusProgress =
      '$_baseUrl/listTaskByStatus/Progress';
  static const String taskByStatusCancelled =
      '$_baseUrl/listTaskByStatus/Cancelled';
  static const String taskByStatusCompleted =
      '$_baseUrl/listTaskByStatus/Completed';

  static String updateTaskStatus(String id, String newStatus) =>
      '$_baseUrl/updateTaskStatus/$id/$newStatus';

  static String deleteTaskStatus(String id) => '$_baseUrl/deleteTask/$id';
  static const String updateProfile = '$_baseUrl/ProfileUpdate';

  static String emailVerify(String email) =>
      '$_baseUrl/RecoverVerifyEmail/$email';
  static String otpVerify(String email, String otp) =>
      '$_baseUrl/RecoverVerifyOtp/$email/$otp';
  static const String resetPassword =
      '$_baseUrl/RecoverResetPassword';
}

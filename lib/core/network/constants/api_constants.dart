class ApiConstants {
  /// [Base Configuration]
  //  static const String baseDomain = 'https://backend-lady-denily-ysw0.onrender.com';
  // static const String baseDomain = 'http://10.10.5.33:8001'; //
  // static const String baseDomain = 'http://10.10.5.59:8001'; // iftikhar
  static const String baseDomain = 'http://10.10.5.88:8001'; // soykot
  static const String baseUrl = '$baseDomain/api/v1';

  /// [Headers]
  static Map<String, String> get defaultHeaders => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Map<String, String> authHeaders(String token) => {
    ...defaultHeaders,
    'Authorization': 'Bearer $token',
  };

  static Map<String, String> get multipartHeaders => {
    'Accept': 'application/json',
    // Content-Type will be set automatically for multipart
  };

  /// [Endpoint Groups]
  static AuthEndpoints get auth => AuthEndpoints();

  static UserEndpoints get user => UserEndpoints();
  static NotificationEndpoints get notification => NotificationEndpoints();

  static TeamEndpointcs get team => TeamEndpointcs();
  static LeagueEndpoints get league => LeagueEndpoints();
  static CourseEndpoints get course => CourseEndpoints();
}

/// [Authentication Endpoints]
class AuthEndpoints {
  static const String _base = '${ApiConstants.baseUrl}/auth';

  final String login = '$_base/login';
  final String register = '$_base/register';
  final String otpVerifyRegister = '$_base/verify';
  final String resetPass = '$_base/forget';
  final String refreshToken = '$_base/refresh-token';
  final String otpVerify = '$_base/verify-reset-otp';

  final String setNewPass = '$_base/reset-password';

  final String changePassword = '$_base/change-password';
}

class UserEndpoints {
  static const String _base = '${ApiConstants.baseUrl}/user';
  final String updateProfile = '$_base/update-profile';
  final String getUserProfile = '$_base/profile';

  // final String create = '$_base/create';
}

class NotificationEndpoints {
  static const String _base = '${ApiConstants.baseUrl}/notification';

  final String getnotifications = '$_base/getnotifications';
}

class TeamEndpointcs {
  static const String _base = '${ApiConstants.baseUrl}/team';

  final String create = '$_base/create';
}

class LeagueEndpoints {
  static const String _base = '${ApiConstants.baseUrl}/league';

  final String getAllLeagues = '$_base/all-league';
}

/// [Course Endpoints] -- zafor
class CourseEndpoints {
  static const String _base = '${ApiConstants.baseUrl}/course';

  final String getAllCourses = '$_base/all-courses';
  final String getCourseDetails = '$_base/courses';
  final String getCourseModules = '$_base/modules';
}

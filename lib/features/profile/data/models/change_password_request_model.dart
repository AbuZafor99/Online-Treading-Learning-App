class ChangePasswordRequest {
  final String oldPassword;
  final String newPassword;

  ChangePasswordRequest({required this.oldPassword, required this.newPassword});

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {'oldPassword': oldPassword, 'newPassword': newPassword};
  }

  // Optional: Create from JSON
  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) {
    return ChangePasswordRequest(
      oldPassword: json['oldPassword'],
      newPassword: json['newPassword'],
    );
  }
}

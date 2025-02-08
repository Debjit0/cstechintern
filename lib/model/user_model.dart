class UserModel {
  final String userId;
  final String deviceId;

  UserModel({required this.userId, required this.deviceId});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json["userId"],
      deviceId: json["deviceId"],
    );
  }
}

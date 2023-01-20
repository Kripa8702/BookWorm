import 'dart:convert';

class UserModel{
  String userId;
  String username;
  String email;
  String password;
  String? profilePic;
  List<String>? moodTags;

  UserModel({
    required this.userId,
    required this.username,
    required this.email,
    required this.password,
    this.profilePic,
    this.moodTags,
});

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      userId: jsonData["userId"] != null ? jsonData["userId"] : "NA",
      username: jsonData["username"] != null ? jsonData["username"] : "NA",
      email: jsonData["email"] != null ? jsonData["email"] : "NA",
      password: jsonData["password"] != null ? jsonData["password"] : "NA",
      profilePic: jsonData["profilePic"] != null ? jsonData["profilePic"] : "NA",
      moodTags: List<String>.from(jsonData["moodTags"]??[]) ,
    );
  }

  static Map<String, dynamic> toMap(UserModel userModel) => {
    'userId': userModel.userId,
    'username': userModel.username,
    'email': userModel.email,
    'password': userModel.password,
    'profilePic': userModel.profilePic,
    'moodTags': userModel.moodTags,
  };

  static String encode(var users) => json.encode(
    users
        .map<Map<String, dynamic>>((user) => UserModel.toMap(user))
        .toList(),
  );

  static List<UserModel> decode(String users) =>
      (json.decode(users) as List<dynamic>)
          .map<UserModel>((user) => UserModel.fromJson(user))
          .toList();
}
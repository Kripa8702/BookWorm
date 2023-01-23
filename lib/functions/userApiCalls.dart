import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:kimber/models/userModel.dart';

class UserApiCalls {
  String userApiUrl = dotenv.env['userApiUrl'].toString();

  registerUser(String username, String email, String password) async {
    try {
      Map data = {
        "username": username,
        "email": email,
        "password": password,
      };

      String body = json.encode(data);

      Uri url = Uri.parse("$userApiUrl/register");

      http.Response response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: body);
      print(response.body);

      var jsonData = await jsonDecode(response.body);
      if (response.statusCode == 200) {
        UserModel userModel = UserModel.fromJson(jsonData);
        return userModel;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  loginUser(String email, String password) async {
    try {
      Map data = {
        "email": email,
        "password": password,
      };

      String body = json.encode(data);

      Uri url = Uri.parse("$userApiUrl/login");

      http.Response response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: body);
      print(response.body);

      var jsonData = await jsonDecode(response.body);
      if (response.statusCode == 200) {
        UserModel userModel = UserModel.fromJson(jsonData);
        return userModel;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  getOneUser(String userId) async {
    try {
      Uri url = Uri.parse("$userApiUrl/getOne/$userId");

      http.Response response = await http.get(url);
      print(response.body);

      var jsonData = await jsonDecode(response.body);

      if (response.statusCode == 200) {
        UserModel userModel = UserModel.fromJson(jsonData[0]);

        return userModel;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}

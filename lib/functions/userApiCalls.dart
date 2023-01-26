import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:kimber/models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
  encryptedSharedPreferences: true,
);

final _storage = FlutterSecureStorage(
    aOptions: _getAndroidOptions()
);

class UserApiCalls {
  String userApiUrl = dotenv.env['userApiUrl'].toString();

  registerUser(String username, String email, String password) async {
    var tempList = [];

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

      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (response.statusCode == 200) {
        UserModel userModel = UserModel.fromJson(jsonData);
        prefs?.setBool("isLoggedIn", true);

        tempList.add(userModel);

        final String encodedData = UserModel.encode(tempList);
        await _storage.write(key: 'currentUser', value: encodedData);

        return userModel;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  loginUser(String email, String password) async {
    var tempList = [];

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

      SharedPreferences prefs = await SharedPreferences.getInstance();

      var jsonData = await jsonDecode(response.body);
      if (response.statusCode == 200) {
        UserModel userModel = UserModel.fromJson(jsonData);
        prefs?.setBool("isLoggedIn", true);

        tempList.add(userModel);

        final String encodedData = UserModel.encode(tempList);
        await _storage.write(key: 'currentUser', value: encodedData);

        return userModel;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  updateProfilePic(String imageUrl, String about, String userId) async {
    try {
      Map data = {};
      if (imageUrl.isNotEmpty && about.isNotEmpty)
        data = {
          "profilePic": imageUrl,
          "about": about,
        };
      else if (about.isEmpty)
        data = {
          "profilePic": imageUrl,
        };
      else if (imageUrl.isEmpty)
        data = {
          "about": about,
        };

      String body = json.encode(data);

      Uri url = Uri.parse("$userApiUrl/update/$userId");

      http.Response response = await http.patch(url,
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

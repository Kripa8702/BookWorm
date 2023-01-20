import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:kimber/models/userModel.dart';

class UserApiCalls {
  String userApiUrl = dotenv.env['userApiUrl'].toString();

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

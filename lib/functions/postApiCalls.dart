import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:kimber/models/postModel.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
  encryptedSharedPreferences: true,
);

final _storage = FlutterSecureStorage(
    aOptions: _getAndroidOptions()
);

class PostApiCalls{
  String postApiUrl = dotenv.env['postApiUrl'].toString();

  getAllPosts() async{

    try{
      Uri url = Uri.parse("$postApiUrl/getAll");

      http.Response response = await http.get(url);
      print(response.body);

      var jsonData = await jsonDecode(response.body);
      var postList = [];
      
      if(response.statusCode == 200){
        for(var json in jsonData){
          PostModel postModel = PostModel.fromJson(json);

          postList.add(postModel);
        }
        final String encodedData = PostModel.encode(postList);
        await _storage.write(key: 'allPosts', value: encodedData);

        // MyUserModel model = MyUserModel.deserialize(await storage.read(key: key));

        return postList;
      }
      return null;

    } catch(e) {
      print(e);
      return null;
    }
  }
}
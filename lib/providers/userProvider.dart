import 'package:book_worm/firebaseResources/authMethods.dart';
import 'package:book_worm/models/userModel.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  AuthMethods authMethods = AuthMethods();

  UserModel get getUser => _user!;

  Future<void> refreshUser() async {
    UserModel user = await authMethods.getCurrentUser();
    _user = user;
    print("USER IS $_user");
    notifyListeners();
  }
}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:login_app_flutter/models/user.dart';
import 'package:login_app_flutter/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
  Status status = Status.Authenticating;
  User user = User();
  UserService userService = UserService();

  UserProvider.instance() {
    isLogin();
  }

  Future getUser() async {
    user = await userService.getUser();
  }

  Future isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwt');

    if (token != null) {
      await getUser();
      status = Status.Authenticated;
    } else {
      await prefs.remove('jwt');
      status = Status.Unauthenticated;
    }
    notifyListeners();
  }

  Future<bool> signIn(String email, String password) async {
    try {
      status = Status.Authenticating;
      notifyListeners();
      var result =
          await userService.signIn(User(email: email, password: password));

      if (result) {
        status = Status.Authenticated;
        await getUser();
        notifyListeners();
        return true;
      }

      status = Status.Unauthenticated;
      notifyListeners();
      return false;
    } catch (e) {
      status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<bool> signUp(User user, BuildContext context) async {
    try {
      var result = await userService.signUp(user);
      print(result);

      if (result) {
        Navigator.pop(context);
        return true;
      }

      return false;
    } catch (e) {
      status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      var result = await userService.signOut();

      if (result) {
        status = Status.Unauthenticated;
        notifyListeners();
        return true;
      }

      status = Status.Unauthenticated;
      notifyListeners();
      return false;
    } catch (e) {
      status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }
}

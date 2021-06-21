import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login_app_flutter/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Future<bool> signIn(User user) async {
    var res = await http.post("http://10.0.2.2:3000/api/signin",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{'email': user.email, 'password': user.password}));

    if (res.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = jsonDecode(res.body);
      await prefs.setString('jwt', token["token"]);
      return true;
    }
    return false;
  }

  Future<bool> signUp(User user) async {
    var res = await http.post("http://10.0.2.2:3000/api/signup",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'firstName': user.firstName,
          'lastName': user.lastName,
          'email': user.email,
          'password': user.password
        }));

    if (res.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<bool> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');

    var res = await http.post(
      "http://10.0.2.2:3000/api/signout",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<User> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwt');

    if (token != null) {
      var res = await http.get(
        "http://10.0.2.2:3000/api/auth/me",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      var body = jsonDecode(res.body);
      return User(id: body["user"]["_id"], email: body["user"]["email"]);
    }
    return User();
  }
}

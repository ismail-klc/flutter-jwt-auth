import 'package:flutter/material.dart';
import 'package:login_app_flutter/models/user.dart';
import 'package:login_app_flutter/provider/user_provider.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var email = "";
    var firstName = "";
    var lastName = "";
    var password = "";
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black26,
          title: Text("Register"),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(2.0, 25.0, 2.0, 2.0),
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(hintText: "First Name"),
                  onChanged: (val) {
                    firstName = val;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(2.0, 25.0, 2.0, 2.0),
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(hintText: "Last Name"),
                  onChanged: (val) {
                    lastName = val;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(2.0, 25.0, 2.0, 2.0),
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(hintText: "Email"),
                  onChanged: (val) {
                    email = val;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(2.0, 5.0, 2.0, 2.0),
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(hintText: "Password"),
                  onChanged: (val) {
                    password = val;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40.0),
                child: MaterialButton(
                  color: Colors.black26,
                  textColor: Colors.white,
                  padding:
                      EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                  onPressed: () async {
                    final userProvider =
                        Provider.of<UserProvider>(context, listen: false);
                    User user = User(
                        firstName: firstName,
                        lastName: lastName,
                        email: email,
                        password: password);
                    print(user);
                    await userProvider.signUp(user, context);
                  },
                  child: Text("Register"),
                ),
              )
            ],
          ),
        ));
  }
}

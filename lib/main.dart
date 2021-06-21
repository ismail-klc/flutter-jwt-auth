import 'package:flutter/material.dart';
import 'package:login_app_flutter/provider/user_provider.dart';
import 'package:login_app_flutter/screens/home_screen.dart';
import 'package:login_app_flutter/screens/login_screen.dart';
import 'package:login_app_flutter/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider.instance())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home: ScreensController()),
    );
  }
}

class ScreensController extends StatelessWidget {
  const ScreensController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    switch (user.status) {
      case Status.Uninitialized:
        return Splash();
      case Status.Authenticated:
        return HomeScreen();
      case Status.Authenticating:
        return Splash();
      case Status.Unauthenticated:
        return LoginScreen();
      default:
        return LoginScreen();
    }
  }
}

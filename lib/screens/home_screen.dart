import 'package:flutter/material.dart';
import 'package:login_app_flutter/provider/user_provider.dart';
import 'package:login_app_flutter/widgets/snackbar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context)
                .showSnackBar(customSnackBar("Floating action button pressed"));
          },
          backgroundColor: Colors.black26,
          child: Icon(
            Icons.message,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context)
                      .showSnackBar(customSnackBar("Search button pressed"));
                },
                child: Icon(Icons.search),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context)
                      .showSnackBar(customSnackBar("More button pressed"));
                },
                child: Icon(Icons.more_vert_rounded),
              ),
            )
          ],
          backgroundColor: Colors.black26,
          title: Text("Home"),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.camera)),
              Tab(
                text: "Chat",
              ),
              Tab(
                text: "Profile",
              ),
              Tab(
                text: "Settings",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Icon(Icons.camera),
            Icon(Icons.directions_car),
            Icon(Icons.directions_transit),
            Center(
              child: Column(
                children: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                    child: Text("Email: ${userProvider.user.email}"),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                    child: Text("Id: ${userProvider.user.id}"),
                  ),
                  MaterialButton(
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                    onPressed: () async {
                      await userProvider.signOut();
                    },
                    color: Colors.black26,
                    child: Text(
                      "Logout",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

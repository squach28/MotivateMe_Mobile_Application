import 'package:flutter/material.dart';
import 'package:motivateme_mobile_app/login_page.dart';
import 'package:motivateme_mobile_app/service/inspire_me.dart';
import 'signup_page.dart';
import 'service/auth.dart';
import 'model/sign_up_result.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService authService = AuthService();
  final InspireMeService inspireMeService = InspireMeService();
  @override
  Widget build(BuildContext context) {
    // 2
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              authService.logout();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()));
            },
            child: Text('Sign Out'),
          ),
        ],
        automaticallyImplyLeading: false,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [const Color(0xffB7F8DB), const Color(0xff50A7C2)],
          )),
        ),
      ),
      // 3
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment
                .centerRight, // 10% of the width, so there are ten blinds.
            colors: [
              const Color(0xffB7F8DB),
              const Color(0xff50A7C2)
            ], // red to yellow
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
          ),
        ),
        child: Center(
          child: Container(
              // 4
              child: Stack(children: [
            // Login form            // 6
            // Sign Up Button
            Container(
                padding: EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0),
                alignment: Alignment.bottomCenter,
                child: TextButton(
                  onPressed: () async {
                    var url =
                        await inspireMeService.inspireMe(); // TODO delete this
                    return showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('AWS Test'),
                            content: SingleChildScrollView(
                                child: Image.network(url)),
                            actions: [
                              TextButton(
                                  child: Text('Very Nice'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  })
                            ],
                          );
                        });
                  },
                  child: new Text(
                    'Inspire Me',
                    style: new TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                ))
          ])),
        ),
      ),
    );
  }
}

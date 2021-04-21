import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:motivateme_mobile_app/login_page.dart';

import 'service/auth.dart';

class ProfilePage extends StatelessWidget {
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
      padding: EdgeInsets.only(top: 75.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        FutureBuilder(
            future: Amplify.Auth.fetchUserAttributes(),
            builder: (BuildContext context,
                AsyncSnapshot<List<AuthUserAttribute>> snapshot) {
              if (snapshot.hasData) {
                List<AuthUserAttribute> firstName = snapshot.data
                    .where((element) =>
                        element.userAttributeKey == 'custom:first_name')
                    .toList();
                List<AuthUserAttribute> lastName = snapshot.data
                    .where((element) =>
                        element.userAttributeKey == 'custom:last_name')
                    .toList();
                String fullName =
                    firstName.first.value + ' ' + lastName.first.value;

                return Text(fullName, style: TextStyle(fontSize: 30,));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
        TextButton(
            child: Text('Sign Out'),
            onPressed: () {
              authService.logout();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()));
            }),
      ]),
    )));
  }
}

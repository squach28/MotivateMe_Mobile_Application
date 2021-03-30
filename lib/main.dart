import 'package:flutter/material.dart';
import 'login_page.dart';
import 'service/auth.dart';
import 'signup_page.dart';
import 'home_page.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:motivateme_mobile_app/amplifyconfiguration.dart';

void main() {
  runApp(MyApp());
}

// 1
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MotivateMe',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
        // 2
        home: FutureBuilder(
          future: authService.checkUserSession(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == true) {
                return HomePage();
              } else {
                return LoginPage();
              }
            } else {
              return Scaffold(body: CircularProgressIndicator());
            }
          },
        )
        // home: Navigator(
        //   pages: [
        //     MaterialPage(child: HomePage()),
        //     MaterialPage(child: SignUpPage()),
        //     MaterialPage(child: LoginPage())
        //   ],
        //   onPopPage: (route, result) => route.didPop(result),
        // ),
        );
  }

  void _configureAmplify() async {
    Amplify.addPlugin(AmplifyAuthCognito());
    await Amplify.configure(amplifyconfig);
  }
}

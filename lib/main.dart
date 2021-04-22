import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'login_page.dart';
import 'service/auth.dart';
import 'home_page.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:motivateme_mobile_app/amplifyconfiguration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;
  final Future<Database> database =
      openDatabase(join(await getDatabasesPath(), 'motivate_me.db'),
          onCreate: (db, version) {
    // create the database if it doesn't exist

    return db.execute(
        "CREATE TABLE Goals(id INTEGER, title TEXT, description TEXT, monday INTEGER, tuesday INTEGER, wednesday INTEGER, thursday INTEGER, friday INTEGER, saturday INTEGER, sunday INTEGER, start_time DATETIME, end_time DATETIME, is_complete INTEGER)");
  }, version: 1);
  runApp(MyApp(
    camera: firstCamera,
  ));
}

// 1
class MyApp extends StatefulWidget {
  final CameraDescription camera;

  MyApp({
    Key key,
    @required this.camera,
  }) : super(key: key);
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
                return HomePage(
                  camera: widget.camera,
                );
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
    Amplify.addPlugins([AmplifyAuthCognito(), AmplifyStorageS3()]);
    await Amplify.configure(amplifyconfig);
  }
}

import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'service/auth.dart';
import 'model/sign_up_result.dart';
import 'service/inspire_me.dart'; 

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 1
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService authService = AuthService();
  final InspireMeService inspireMeService =
      InspireMeService(); 

  @override
  Widget build(BuildContext context) {
    // 2
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
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
            // Login form
            _loginForm(),
            // 6
            // Sign Up Button
            Container(
                padding: EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0),
                alignment: Alignment.bottomCenter,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: new Text(
                    'Don\'t have an account? Sign up',
                    style: new TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                ))
          ])),
        ),
      ),
    );
  }

  // 5
  Widget _loginForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Username TextField
        // Username TextField
        TextField(
          controller: _usernameController,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            prefixIcon: Icon(Icons.person),
            hintText: 'Username',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(10.0),
        ),

        // Password TextField
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            prefixIcon: Icon(Icons.lock),
            hintText: 'Password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
        ),

        Padding(
          padding: const EdgeInsets.all(16.0),
        ),

        // Login Button
        SizedBox(
          width: 300.0,
          height: 40.0,
          child: OutlinedButton(
            child: new Text(
              'Login',
              style: new TextStyle(fontSize: 17.0, color: Colors.black),
            ),
            onPressed: _login,
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.tealAccent),
              elevation: MaterialStateProperty.all<double>(10.0),
              side: MaterialStateProperty.all<BorderSide>(
                BorderSide(width: 3.0, color: Colors.black),
              ),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  side: BorderSide(width: 3, color: Colors.black),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

// 7
  Future<void> _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    print('username: $username');
    print('password: $password');

    authService.login(username, password);
    /*var url = await inspireMeService.inspireMe(); // TODO delete this
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('AWS Test'),
            content: SingleChildScrollView(child: Image.network(url)),
            actions: [
              TextButton(
                  child: Text('Very Nice'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ],
          );
        }); */
  }
}

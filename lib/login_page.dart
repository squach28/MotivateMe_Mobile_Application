import 'package:flutter/material.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 1
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // 2
    return Scaffold(
      appBar: AppBar(
          title: const Text('Login Page'),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.green),
      // 3
      body: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 40),
          // 4
          child: Stack(children: [
            // Login form
            _loginForm(),

            // 6
            // Sign Up Button
            Container(
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
                    style: new TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ))
          ])),
    );
  }

  // 5
  Widget _loginForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Username TextField
        TextField(
          controller: _usernameController,
          decoration:
              InputDecoration(icon: Icon(Icons.mail), labelText: 'Username'),
        ),

        Padding(
          padding: const EdgeInsets.all(10.0),
        ),

        // Password TextField
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
              icon: Icon(Icons.lock_open), labelText: 'Password'),
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
        ),

        Padding(
          padding: const EdgeInsets.all(16.0),
        ),

        // Login Button
        ButtonTheme(
          minWidth: 300.0,
          height: 40.0,
          buttonColor: Colors.green,
          child: RaisedButton(
            child: new Text(
              'Login',
              style: new TextStyle(
                fontSize: 17.0,
              ),
            ),
            onPressed: _login,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
            side: BorderSide(width: 3.0, color: Colors.black),
          ),
        )
      ],
    );
  }

// 7
  void _login() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    print('username: $username');
    print('password: $password');
  }
}

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
      // 3
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 40),
        // 4
        child: Stack(
          children: [
            // Login form
            _loginForm(),

            // 6 
            // Sign Up Button
            Container(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: () {Navigator.push(context, MaterialPageRoute(builder:(context) => SignUpPage()),);},
                child: Text('Don\'t have an account? Sign up.'),
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
          decoration: InputDecoration(icon: Icon(Icons.mail), labelText: 'Username'),
        ),
    
        // Password TextField
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(icon: Icon(Icons.lock_open), labelText: 'Password'),
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
        ),

          // Login Button
          TextButton(
            onPressed: _login,
            child: Text('Login'),
            style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green))
          ),
    
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

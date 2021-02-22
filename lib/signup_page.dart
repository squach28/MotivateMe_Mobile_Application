import 'package:flutter/material.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Signup Page'),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.green),
      body: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 40),
          child: Stack(children: [
            // Sign Up Form
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 50.0),
              child: Column(
                children: <Widget> [
                  _signUpForm(),
                  SizedBox(height: 40.0),
                              Container(
              alignment: Alignment.bottomCenter,
              child: TextButton(
// <<<<<<< Jasmit_Branch
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: new Text(
                    'Already have an account? Login',
                    style: new TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
              ),
            ),
          ])),
    );
  }

  Widget _signUpForm() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      //FirstName TextField
      TextField(
        controller: _firstNameController,
        decoration:
            InputDecoration(icon: Icon(Icons.person), labelText: 'First Name'),
      ),

      //LastName TextField
      TextField(
        controller: _lastNameController,
        decoration:
            InputDecoration(icon: Icon(Icons.person), labelText: 'Last Name'),
      ),

      // Username TextField
      TextField(
        controller: _usernameController,
        decoration:
            InputDecoration(icon: Icon(Icons.person), labelText: 'Username'),
      ),

      // Email TextField
      TextField(
        controller: _emailController,
        decoration: InputDecoration(icon: Icon(Icons.mail), labelText: 'Email'),
      ),

      // Password TextField
      TextField(
        controller: _passwordController,
        decoration:
            InputDecoration(icon: Icon(Icons.lock_open), labelText: 'Password'),
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
      ),

      Padding(
        padding: const EdgeInsets.all(16.0),
      ),

      // Sign Up Button
// <<<<<<< Jasmit_Branch
      ButtonTheme(
          minWidth: 300.0,
          height: 40.0,
          buttonColor: Colors.blue,
          child: RaisedButton(
            child: new Text(
              'Sign Up',
              style: new TextStyle(
                fontSize: 17.0,
              ),
            ),
            onPressed: _signUp,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
            side: BorderSide(width: 3.0, color: Colors.black),
          ),
        )
    ]);
  }

  void _signUp() {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    print('firstName: $firstName');
    print('lastName: $lastName');
    print('username: $username');
    print('email: $email');
    print('password: $password');
  }
}

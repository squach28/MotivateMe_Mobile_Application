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
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [const Color(0xffB7F8DB), const Color(0xff50A7C2)],
          )),
        ),
      ),
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
              child: Stack(children: [
            // Sign Up Form
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0),
              child: Column(children: <Widget>[
                _signUpForm(),
                SizedBox(height: 40.0),
                // Login Button
                Container(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
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
              ]),
            ),
          ])),
        ),
      ),
    );
  }

  Widget _signUpForm() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      //FirstName TextField
      TextField(
        controller: _firstNameController,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(Icons.person),
          hintText: 'First Name',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: BorderSide(width: 3.0, color: Colors.red),
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.all(10.0),
      ),

      //LastName TextField
      TextField(
        controller: _lastNameController,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(Icons.person),
          hintText: 'Last Name',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.all(10.0),
      ),

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

      // Email TextField
      TextField(
        controller: _emailController,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(Icons.email),
          hintText: 'Email',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
        // decoration: InputDecoration(icon: Icon(Icons.mail), labelText: 'Email'),
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

      // Sign Up Button
      SizedBox(
        width: 300.0,
        height: 40.0,
        child: OutlinedButton(
          child: new Text(
            'Sign Up',
            style: new TextStyle(fontSize: 17.0, color: Colors.black),
          ),
          onPressed: _signUp,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),
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

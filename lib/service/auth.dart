import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';

class AuthService {

  // creates an account for the user with params username, password, and name
  void signUp(String username, String password, String email) async {

    Map<String, String> userAttributes = {
      'email': email
    };
    
    try {
      SignUpResult res = await Amplify.Auth.signUp(
        username: username,
        password: password,
        options: CognitoSignUpOptions(
          userAttributes: userAttributes,
        )
      );
      print('sign up!');

    } on AuthException catch(e) {
      print(e.message);
    }
  }

  // log the user into his/her account with params username and password
  // authexception occurs if params are invalid
  void login(String username, String password) async {
    try {
    SignInResult res = await Amplify.Auth.signIn(
      username: username,
      password: password
    );
    print('log in!');

    } on AuthException catch(e) {
      print(e.message);
    }
  }

  // log the user out of the current session
  // local cache and keychain will be deleted
  void logout() {
    try {
      Amplify.Auth.signOut();
    } on AuthException catch(e) {
      print(e.message);
    }
  }

}
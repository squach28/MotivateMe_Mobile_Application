import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';

class AuthService {

  // creates an account for the user with params username and password
  void signUp(String username, String password) async {

    // required name attribute 
    Map<String, String> userAttributes = {
      'name': 'name',

    };
    
    try {
      SignUpResult res = await Amplify.Auth.signUp(
        username: username,
        password: password,
        options: CognitoSignUpOptions(
            userAttributes: userAttributes
        )
      );

      print('sign up!');
    } on AuthException catch(e) {
      print(e.message);
    }
  }
}
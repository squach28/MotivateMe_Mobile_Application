import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:motivateme_mobile_app/model/sign_up_result.dart' as mm;
import 'package:motivateme_mobile_app/model/sign_in_result.dart' as mm;

// class that handles authentication for user login and signup
class AuthService {
  // creates an account for the user with params username, password, and email
  Future<mm.SignUpResult> signUp(
      String username, String password, String email) async {
    Map<String, String> userAttributes = {
      'email': email // email is a required attribute for successful sign up
    };

    try {
      SignUpResult res = await Amplify.Auth.signUp(
          username: username,
          password: password,
          options: CognitoSignUpOptions(
            userAttributes: userAttributes,
          ));

      return mm.SignUpResult.SUCCESS;
    } on AuthException catch (e) {
      print('runtime type: ' + e.runtimeType.toString());
      if (e.runtimeType == UsernameExistsException) {
        // throw exception if username OR email is already taken
        return mm.SignUpResult.USERNAME_ALREADY_EXISTS;
      } else if (e.runtimeType == InvalidParameterException) {
        // throw exception if password doesn't have enough characters
        return mm.SignUpResult.WEAK_PASSWORD;
      } else {
        // general case for other failures
        return mm.SignUpResult.FAIL;
      }
    }
  }

  // log the user into his/her account with params username and password
  // authexception occurs if params are invalid
  Future<mm.SignInResult> login(String username, String password) async {
    try {
      SignInResult res =
          await Amplify.Auth.signIn(username: username, password: password);
      print('log in!');

      return mm.SignInResult.SUCCESS;
    } on AuthException catch (e) {
      print(e.runtimeType);
    }
  }

  Future<bool> checkUserSession() async {
    var authSession = await Amplify.Auth.fetchAuthSession();
    return authSession.isSignedIn;
  }

  // log the user out of the current session
  // local cache and keychain will be deleted
  void logout() {
    try {
      Amplify.Auth.signOut();
    } on AuthException catch (e) {
      print(e.message);
    }
  }
}

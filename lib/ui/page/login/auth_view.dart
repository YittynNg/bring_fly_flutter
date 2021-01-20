import './login_view.dart';
import './forgot_password_view.dart';
import './signup_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('<ROOT>');
    // return RootAuth(
    //   authenticated: () => Home(''), 
    //   unauthenticated: () => LoginPage()
    // );
    return Consumer<AuthViewController>(
      builder: (BuildContext context, AuthViewController view, __) {
        switch (view.index) {
          case 0:
            return LoginView();
          case 1:
            return ForgotPasswordView();
          case 2:
            return SignUpView();
          default:
            return LoginView();
        }
      },
    );
  }
}

class AuthViewController extends ChangeNotifier {
  int index = 0;

  void goToForgotPassword() {
    index = 1;
    notifyListeners();
  }

  void goToSignUp() {
    index = 2;
    notifyListeners();
  }

  void goToLogIn() {
    index = 0;
    notifyListeners();
  }
}
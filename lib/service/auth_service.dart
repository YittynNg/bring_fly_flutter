import 'package:bringfly_uniwallet/common/mock_data.dart';
import 'package:bringfly_uniwallet/service/db.dart';
import 'package:flutter/foundation.dart';
import '../util/validator.dart';
import 'package:logger/logger.dart';
import '_exception.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../util/network_config.dart';
import '../logger.dart';
import '../locator.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Unauthenticated,
}

enum AuthStatus {
  Uninitialized,
  Authenticated,
  Unauthenticated,
}

class AuthService extends ChangeNotifier {
  AuthStatus _status = AuthStatus.Uninitialized;
  AuthStatus get status => _status;

  Logger log = getLogger("AuthService");
  final String service;

  bool firstTime = false;

  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      // 'https://www.googleapis.com/auth/contacts.readonly',
    ]
  );

  AuthService({this.service = 'http://localhost:8091'});

  Future<void> init() async {
    log.i('loadToken');
    while(!locator<DB>().loaded) {
      await Future.delayed(Duration(milliseconds: 100));
    }
    if(locator<DB>().checkAuthToken()) _status = AuthStatus.Authenticated;
    else _status = AuthStatus.Unauthenticated;
    notifyListeners();
  }

  // return boolean, whether is a first time user
  Future<bool> signIn({String email = '', String password = ''}) async {
    try {
      await Future.delayed(Duration(seconds: 1));
      if(email != MockData.email || password != MockData.password) {
        _status = AuthStatus.Unauthenticated;
        locator<DB>().setAuthToken(false);
        notifyListeners();
        throw(Exception('Email or password incorrect'));
      }
      _status = AuthStatus.Authenticated;
      locator<DB>().setAuthToken(true);
      notifyListeners();
      return true;
    } catch(e) {
      print('--- GOOGLE sign in ERR ---');
      _status = AuthStatus.Unauthenticated;
      locator<DB>().setAuthToken(false);
      notifyListeners();
      throw(e);
    }
  }

  Future<void> refresh() async {
    // await signInSilently();
  }

  Future<void> signOut() async {
    log.i('Signing Out');
    await googleSignIn.signOut();
    _status = AuthStatus.Unauthenticated;
    locator<API>().setAuthorization(null, null);
    notifyListeners();
  }
}

import 'package:flutter/foundation.dart';
import './notification/push_notification.dart';
import '../util/validator.dart';
import 'package:logger/logger.dart';
import '_exception.dart';
import '../model/user.dart';
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

  User user;
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
    // await signInSilently();
    _status = AuthStatus.Unauthenticated;
    notifyListeners();
  }

  // return boolean, whether is a first time user
  Future<bool> signIn() async {
    try {
      await Future.delayed(Duration(seconds: 1));
      _status = AuthStatus.Authenticated;
      notifyListeners();
      return true;
    } catch(e) {
      print('--- GOOGLE sign in ERR ---');
        _status = AuthStatus.Unauthenticated;
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

  // return boolean, whether is a first time user
  Future<User> getUser(String id) async {
    try {
      try {
        Map<String, dynamic> result = await locator<API>().get(service, '/api/user/user/$id');
        var user = User.fromJson(result);
        return user;
      } catch(e) {
        print('--- API ERR ---');
        // _status = AuthStatus.Unauthenticated;
        notifyListeners();
        log.e(e);
        throw(checkServiceError(e));
      }
    } catch(e) {
      print('--- getUser Err ---');
      throw(e);
    }
  }

  Future<User> searchUser(String word) async {
    // use email
    try {
      try {
        Map<String, dynamic> result = await locator<API>().get(service, '/api/user/search/$word');
        var user = User.fromJson(result);
        return user;
      } catch(e) {
        print('--- API ERR ---');
        // _status = AuthStatus.Unauthenticated;
        notifyListeners();
        log.e(e);
        throw(checkServiceError(e));
      }
    } catch(e) {
      print('--- getUser Err ---');
      throw(e);
    }
  }
}

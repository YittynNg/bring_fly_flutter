import 'package:flutter/material.dart';
import '../locator.dart';
import '../logger.dart';
import './auth_service.dart';

import '_hive.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../model/user.dart';

class DB extends ChangeNotifier {
  DB() {
    init();
  }
  
  bool _loaded = false;
  bool get loaded => _loaded;

  final log = getLogger('DB');
  
  init() async {
    // log.i('Start');
    // // await Hive.initFlutter();
    // Hive.registerAdapter<Message>(MessageAdapter());
    // Hive.registerAdapter<User>(UserAdapter());
    // await Hive.openLazyBox<Message>(HiveBoxes.message);
    // await Hive.openBox<User>(HiveBoxes.user);
    // await Hive.openBox<List<String>>(HiveBoxes.userMessages);
    // await _currentUserSettings();
    // await _loadUsers();
    // log.i('Done');
    // _loaded = true;
    // notifyListeners();
  }
}
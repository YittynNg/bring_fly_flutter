import 'package:bringfly_uniwallet/model/account.dart';
import 'package:bringfly_uniwallet/model/promotion.dart';
import 'package:bringfly_uniwallet/model/transaction.dart';
import 'package:flutter/material.dart';
import '../locator.dart';
import '../logger.dart';
import './auth_service.dart';

import '_hive.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

// flutter packages pub run build_runner build --delete-conflicting-outputs

class DB extends ChangeNotifier {
  DB() {
    // init();
  }
  
  bool _loaded = false;
  bool get loaded => _loaded;

  final log = getLogger('DB');

  Box<bool> _authBox;
  Box<Account> _accountBox;
  LazyBox<Transaction> _transactionBox;
  Box<Promotion> _promotionBox;
  
  init() async {
    // await Hive.initFlutter();
    log.i('Start');
    // await Hive.initFlutter();
    Hive.registerAdapter<Account>(AccountAdapter());
    Hive.registerAdapter<Transaction>(TransactionAdapter());
    Hive.registerAdapter<Promotion>(PromotionAdapter());
    _transactionBox = await Hive.openLazyBox<Transaction>(HiveBoxes.transaction);
    _accountBox = await Hive.openBox<Account>(HiveBoxes.account);
    _promotionBox = await Hive.openBox<Promotion>(HiveBoxes.promotion);
    _authBox = await Hive.openBox<bool>(HiveBoxes.auth);
    _loaded = true;
    notifyListeners();
    log.i('Done');
  }

  bool checkAuthToken() {
    return _authBox.get(0, defaultValue: false);
  }

  setAuthToken(bool save) async {
    _authBox.put(0, save);
  }

  Box<Account> get getAccountBox => _accountBox;
  LazyBox<Transaction> get getTransactionBox => _transactionBox;
  Box<Promotion> get getPromotionBox => _promotionBox;

  @override
  void dispose() {
    _accountBox.close();
    _transactionBox.close();
    _authBox.close();
    super.dispose();
  }
}
import 'package:bringfly_uniwallet/locator.dart';
import 'package:bringfly_uniwallet/logger.dart';
import 'package:bringfly_uniwallet/model/account.dart';
import 'package:bringfly_uniwallet/model/transaction.dart';
import 'package:bringfly_uniwallet/service/db.dart';
import 'package:flutter/foundation.dart';

class AccountService extends ChangeNotifier {
  List<Account> accounts = [];

  List<Transaction> transactions = [];

  final log = getLogger('AccountService');

  init() async {
    while(!locator<DB>().loaded) {
      await Future.delayed(Duration(milliseconds: 100));
    }
    int n = locator<DB>().getAccountBox.length;
    log.i('$n accounts');
    accounts = [];
    for(int i = 0; i < n; i++) {
      accounts.add(locator<DB>().getAccountBox.getAt(i));
    }
    n = locator<DB>().getTransactionBox.length;
    transactions = [];
    for(int i = n-1; i >= 0; i--) {
      transactions.add(await locator<DB>().getTransactionBox.getAt(i));
    }
    notifyListeners();
  }

  double totalBalance() {
    double total = 0;
    for(var acc in accounts) {
      total += acc.balance;
    }
    return total;
  }

  List<Transaction> getTransactionsOf(Account acc) {
    List<Transaction> list = [];
    for(var transaction in transactions) {
      if(transaction.account == acc) {
        list.add(transaction);
      }
    }
    return list;
  }

  Future<void> addAccount(Account acc) async {
    int r = await locator<DB>().getAccountBox.add(acc);
    log.i('Add accounts: $r');
    accounts.add(acc);
    notifyListeners();
  }

  void deleteAccount(Account acc) async {
    // int index;
    // for(int i = 0; i < accounts.length; i++) {
    //   if(accounts[i] == acc) {
    //     index = i;
    //     accounts.remove(acc);
    //   }
    // }
    // await locator<DB>().getAccountBox.deleteAt(index);
    accounts.remove(acc);
    acc.delete();
    notifyListeners();
  }

  Future<void> addTransaction(Transaction t) async {
    await locator<DB>().getTransactionBox.add(t);
    transactions.insert(0, t);
    notifyListeners();
  }

  Future<void> updateAccount(Account acc) async {
    await acc.save();
    notifyListeners();
  }

  /*
  business logic operation
  */
  Future<void> swapBalance(Account from, Account to, double amount) async {
    await Future.delayed(Duration(seconds: 1));
    if(from.balance < amount) {
      throw("Balance Not Enough");
    }
    from.balance -= amount;
    to.balance += amount;
    await from.save();
    await to.save();
    DateTime time = DateTime.now();
    Transaction tFrom = Transaction(
      time: time,
      account: from,
      amount: -amount,
      title: 'Swap to '+to.type
    );
    Transaction tTo = Transaction(
      time: time,
      account: to,
      amount: amount,
      title: 'Swap from '+from.type
    );
    await addTransaction(tFrom);
    await addTransaction(tTo);
    notifyListeners();
  }

  Future<void> topUp(Account acc, double amount, {String note = ''}) async {
    await Future.delayed(Duration(seconds: 1));
    if(acc.balance < amount) {
      throw("Balance Not Enough");
    }
    acc.balance += amount;
    await acc.save();
    DateTime time = DateTime.now();
    Transaction t = Transaction(
      time: time,
      account: acc,
      amount: amount,
      title: 'Top Up '+note
    );
    await addTransaction(t);
    notifyListeners();
  }

  Future<void> pay(Account acc, double amount, {String note = ''}) async {
    await Future.delayed(Duration(seconds: 1));
    acc.balance -= amount;
    await acc.save();
    DateTime time = DateTime.now();
    Transaction t = Transaction(
      time: time,
      account: acc,
      amount: -amount,
      title: 'Pay '+note
    );
    await addTransaction(t);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
import 'package:bringfly_uniwallet/locator.dart';
import 'package:bringfly_uniwallet/model/account.dart';
import 'package:bringfly_uniwallet/model/transaction.dart';
import 'package:bringfly_uniwallet/service/accounts_service.dart';
import 'package:stacked/stacked.dart';

class TransactionHistoryViewModel extends BaseViewModel {
  DateTime from = DateTime.now().subtract(Duration(minutes: 60 * 24 * 31));
  DateTime to = DateTime.now();
  Account account;

  List<Transaction> transactions;

  TransactionHistoryViewModel() {
    transactions = locator<AccountService>().transactions;
  }

  Future<void> filter() async {
    setBusy(true);
    if(account == null) {
      transactions = List.from(locator<AccountService>().transactions, growable: true);
    } else {
      transactions = List.from(locator<AccountService>().getTransactionsOf(account), growable: true);
    }
    if(from != null && to != null) {
      // for(var transaction in transactions) {
      //   if(!transaction.time.isAfter(from) || !transaction.time.isBefore(to)) {
      //     transactions.remove(transaction);
      //   }
      // }
      for(int i = 0; i < transactions.length; i++) {
        var transaction = transactions[i];
        if(!transaction.time.isAfter(from) || !transaction.time.isBefore(to)) {
          transactions.remove(transaction);
          i--;
        }
      }
    }
    setBusy(false);
  }
}
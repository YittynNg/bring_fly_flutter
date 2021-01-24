import 'package:bringfly_uniwallet/locator.dart';
import 'package:bringfly_uniwallet/model/account.dart';
import 'package:bringfly_uniwallet/model/transaction.dart';
import 'package:bringfly_uniwallet/service/accounts_service.dart';
import 'package:stacked/stacked.dart';

class TransactionHistoryViewModel extends BaseViewModel {
  DateTime from;
  DateTime to;
  Account account;

  List<Transaction> transactions;

  TransactionHistoryViewModel() {
    transactions = locator<AccountService>().transactions;
  }

  Future<void> filter() async {
    setBusy(true);
    if(account == null) {
      transactions = locator<AccountService>().transactions;
    } else {
      transactions = locator<AccountService>().getTransactionsOf(account);
    }
    if(from != null && to != null) {
      for(var transaction in transactions) {
        if(!transaction.time.isAfter(from) || !transaction.time.isBefore(to)) {
          transactions.remove(transaction);
        }
      }
    }
    setBusy(false);
  }
}
import '../model/account.dart';
import '../model/transaction.dart';

class MockData {
  // static Map<String, double> accounts = {
  //   'GrabPay': 152.40,
  //   'Boost': 335.7,
  // };

  static List<Account> accounts = [
    Account(
      type: 'GrabPay',
      balance: 152.40
    ),
    Account(
      type: 'Boost',
      balance: 335.70
    )
  ];

  static double totalBalance() {
    double total = 0;
    for(var acc in accounts) {
      total += acc.balance;
    }
    return total;
  }

  static String email = 'example@gmail.com';
  static String password = '00000000';
  static String name = 'example dotcom';

  static List<Transaction> transactions = [
    Transaction(
      amount: -30,
      title: 'Digi',
      account: accounts[0],
      time: DateTime(2020, 12, 29, 15, 24, 32)
    ),
    Transaction(
      amount: -22.75,
      title: '99speedmart',
      account: accounts[1],
      time: DateTime(2020, 12, 28, 10, 02, 44)
    ),
    Transaction(
      amount: -30,
      title: '99speedmart',
      account: accounts[2],
      time: DateTime(2020, 12, 28, 10, 02, 44)
    )
  ];
}


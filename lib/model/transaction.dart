import 'package:hive/hive.dart';

import 'account.dart';

part 'transaction.g.dart';

@HiveType(typeId: 254)
class Transaction extends HiveObject {
  @HiveField(0)
  DateTime time;
  @HiveField(1)
  double amount;
  @HiveField(2)
  Account account;
  @HiveField(3)
  String title;

  Transaction({this.time, this.amount, this.account, this.title});
}
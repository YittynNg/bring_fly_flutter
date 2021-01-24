import 'package:hive/hive.dart';

part 'account.g.dart';

@HiveType(typeId: 0)
class Account extends HiveObject {
  @HiveField(0)
  String type;
  @HiveField(1)
  String phone;
  @HiveField(2)
  double balance;

  Account({this.type = '', this.phone = '', this.balance = 0});
  
  @override
  // TODO: implement hashCode
  int get hashCode => (type + '_' + phone?? '').hashCode;

  operator == (Object acc) {
    if(acc is Account) {
      return acc.hashCode == this.hashCode;
    }
    return false;
  }
}
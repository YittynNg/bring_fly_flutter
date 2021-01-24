import 'package:bringfly_uniwallet/locator.dart';
import 'package:bringfly_uniwallet/model/account.dart';
import 'package:bringfly_uniwallet/service/accounts_service.dart';
import 'package:stacked/stacked.dart';

class AccountViewModel extends BaseViewModel {

  final Account acc;
  
  AccountViewModel(this.acc) {
    locator<AccountService>().addListener(notifyListeners);
  }
  
}
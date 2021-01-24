import 'package:bringfly_uniwallet/model/account.dart';
import 'package:bringfly_uniwallet/service/accounts_service.dart';
import 'package:stacked/stacked.dart';

import '../../../locator.dart';

class HomeViewModel extends BaseViewModel {

  List<Account> get accounts => locator<AccountService>().accounts;

  init() {
    locator<AccountService>().addListener(notifyListeners);
  }

  double totalBalance() {
    return locator<AccountService>().totalBalance();
  }

  @override
  void dispose() {
    locator<AccountService>().removeListener(notifyListeners);
    super.dispose();
  }
}
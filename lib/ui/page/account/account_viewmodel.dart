import 'package:bringfly_uniwallet/locator.dart';
import 'package:bringfly_uniwallet/model/account.dart';
import 'package:bringfly_uniwallet/service/accounts_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AccountViewModel extends BaseViewModel {

  final Account acc;
  
  AccountViewModel(this.acc) {
    locator<AccountService>().addListener(notifyListeners);
  }

  removeAccount() async {
    var result = await locator<DialogService>().showConfirmationDialog(title: 'Delete Account', description: 'Are you sure wanna remove account?', confirmationTitle: 'Remove');
    if(result.confirmed) {
      await locator<AccountService>().deleteAccount(acc);
      locator<NavigationService>().back();
    }
  }
  
}
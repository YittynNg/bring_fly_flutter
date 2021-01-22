import 'package:bringfly_uniwallet/locator.dart';
import 'package:bringfly_uniwallet/model/accounts.dart';
import 'package:bringfly_uniwallet/ui/page/verify/verification_page_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ScanViewModel extends BaseViewModel {
  // temporary
  String selectedType;
  bool recipient;
  Account selectedAccount;

  ScanViewModel();

  Future<void> verifyTransaction() async {
    var result = await locator<NavigationService>().navigateToView(VerificationPage());
    print('From verification: $result');
    if(result != null && result) {
      //
    }
  }
}
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../locator.dart';
import '../../page/verify/verification_page_view.dart';

class ForgotPassword extends BaseViewModel {

  Future<void> sendResetPasswordRequest() async {
    await Future.delayed(Duration(seconds: 1));
    var result = await locator<NavigationService>().navigateToView(VerificationPage());
    print('From verification: $result');
  }
}
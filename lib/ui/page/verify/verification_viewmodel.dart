import '../../../logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../locator.dart';

class VerificationModel extends BaseViewModel {
  final DialogService _dialogService = locator<DialogService>();
  // final ConnectivityService _connection = locator<ConnectivityService>();
  final log = getLogger('Verification Model');

  Future<bool> verifyCode(String code) async {
    await Future.delayed(Duration(seconds: 1));
    return code != '123456'; // whether invalid
  }
}
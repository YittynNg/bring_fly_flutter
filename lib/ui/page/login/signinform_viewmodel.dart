import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../logger.dart';
import '../../../service/_exception.dart';
import '../../../service/auth_service.dart';
import '../../../util/network_config.dart';

import '../../../locator.dart';

class SignInFormModel extends BaseViewModel {
  final DialogService _dialogService = locator<DialogService>();
  final AuthService _authService = locator<AuthService>();
  final log = getLogger('SignInForm Model');

  // ignore: missing_return
  Future<void> checkCanSignIn(
    String email,
    String password,
    {bool remember}
  ) async {
    setBusy(true);
    try {
      await _authService.signIn(email: email, password: password);
      log.d('GET ${_authService.status}');
      if (_authService.status == AuthStatus.Unauthenticated) {
        _dialogService.showDialog(
          title: 'Sign in failed',
          description: "User or password is incorrect",
          dialogPlatform: DialogPlatform.Material,
        );
        setBusy(false);
      }
      setBusy(false);
      log.i('Success login');
    } on ServiceException catch(e) {
      log.e('ServiceE: $e');
      _dialogService.showDialog(
        title: '${e.code}',
        description: "${e.message}",
        dialogPlatform: DialogPlatform.Material,
      );
      setBusy(false);
    } on ApiError catch(e) {
      _dialogService.showDialog(
        title: 'HTTP ${e.statusCode}',
        description: "${e.errorMessage}",
        dialogPlatform: DialogPlatform.Material,
      );
      setBusy(false);
    } catch(e) {
      _dialogService.showDialog(
        title: 'Error',
        description: "$e",
        dialogPlatform: DialogPlatform.Material,
      );
      setBusy(false);
    }
  }
}
import 'package:bringfly_uniwallet/model/account.dart';
import 'package:bringfly_uniwallet/service/accounts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../../locator.dart';

class SwapBalanceViewModel extends BaseViewModel {
  Account accFrom;
  Account accTo;
  double _amount;
  final TextEditingController amountTextController = TextEditingController();

  Future<void> swap() async {
    _amount = double.parse(amountTextController.text);
    setBusy(true);
    await locator<AccountService>().swapBalance(accFrom, accTo, _amount);
    setBusy(false);
  }
}
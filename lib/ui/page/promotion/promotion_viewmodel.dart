import 'package:bringfly_uniwallet/locator.dart';
import 'package:bringfly_uniwallet/model/account.dart';
import 'package:bringfly_uniwallet/model/promotion.dart';
import 'package:bringfly_uniwallet/model/transaction.dart';
import 'package:bringfly_uniwallet/service/accounts_service.dart';
import 'package:bringfly_uniwallet/service/promotion_service.dart';
import 'package:stacked/stacked.dart';

class PromotionHistoryViewModel extends BaseViewModel {
  String account;

  List<Promotion> promotions;

  PromotionHistoryViewModel() {
    promotions = locator<PromotionService>().promotions;
  }

  Future<void> filter() async {
    setBusy(true);
    if(account == null) {
      promotions = List.from(locator<PromotionService>().promotions, growable: true);
    } else {
      promotions = List.from(await locator<PromotionService>().filterAccount(account), growable: true);
    }
    setBusy(false);
  }
}
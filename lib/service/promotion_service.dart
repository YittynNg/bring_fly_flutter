import 'package:bringfly_uniwallet/locator.dart';
import 'package:bringfly_uniwallet/model/promotion.dart';
import 'package:bringfly_uniwallet/service/db.dart';
import 'package:flutter/foundation.dart';

class PromotionService extends ChangeNotifier {
  List<Promotion> promotions = [];
  final DB _db = locator<DB>();

  init() async {
    promotions = _db.getPromotionBox.values.toList();
    // Generate Mock
    if(promotions.length <= 0) {
      var p1 = Promotion(
        img: 'https://storage.getitqec.com/file/yeezcarouselads/3.webp',
        id: '1',
        merchant: 'SushiQueen',
        account: 'TouchNGo',
        title: "Mega Plate RM5 Off",
        description: "This is a description of the promotion. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. "
      );
      var p2 = Promotion(
        img: 'https://storage.getitqec.com/file/yeezcarouselads/2.webp',
        id: '2',
        merchant: 'SushiQueen',
        account: 'Boost',
        title: "Shrimp Sushi RM5 Off",
        description: "This is a description of the promotion. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. "
      );
      var p3 = Promotion(
        img: 'https://pbs.twimg.com/profile_images/1112398460643237888/rFP2PG4I.jpg',
        id: '3',
        merchant: 'GSC',
        account: 'Boost',
        title: "Movie Free Popcorn",
        description: "This is a description of the promotion. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. "
      );
      await _db.getPromotionBox.add(p1);
      await _db.getPromotionBox.add(p2);
      await _db.getPromotionBox.add(p3);
      promotions.add(p1);
      promotions.add(p2);
      promotions.add(p3);
    }
  }

  Future<List<Promotion>> filterMerchant(String merchant, {String account}) async {
    await Future.delayed(Duration(seconds: 1));
    List<Promotion> result = [];
    for(var promotion in promotions) {
      if(promotion.merchant == merchant) {
        if(account == null) {
          result.add(promotion);
        } else if(account == promotion.account) {
          result.add(promotion);
        }
      }
    }
    return result;
  }

  Future<List<Promotion>> filterAccount(String account) async {
    await Future.delayed(Duration(seconds: 1));
    List<Promotion> result = [];
    for(var promotion in promotions) {
      if(account == promotion.account) {
        result.add(promotion);
      }
    }
    return result;
  }
}
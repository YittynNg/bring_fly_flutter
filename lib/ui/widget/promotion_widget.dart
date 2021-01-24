import 'package:bringfly_uniwallet/model/promotion.dart';
import 'package:bringfly_uniwallet/ui/constant/logo.dart';
import 'package:flutter/material.dart';

class PromotionWidget extends StatelessWidget{

  final Promotion promotion;
  final bool logo;

  PromotionWidget(this.promotion, {this.logo = true});

  AssetImage _typeToImage(String type) {
    switch(type) {
      case 'TouchNGo':
        return TouchNGoLogo;
      case 'Boost':
        return BoostLogo;
      case 'GrabPay':
        return GrabPayLogo;
      default:
        return DuitNowQR;
    }
  }
  
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        // height: 60,
        padding: EdgeInsets.only(top: 9),
        // child: ListTile(
        //   title: Text('Title'),
        //   subtitle: Text('Time'),
        //   trailing: Text('-RM255.00'),
        // ),
        child: ListTile(
          leading: promotion.img != null
              ? Image(image: NetworkImage(promotion.img), height: 40, width: 60,)
              : null,
          title: Text(promotion.title),
          subtitle: Text(promotion.description, maxLines: 3,),
          trailing: logo? Image(image: _typeToImage(promotion.account), height: 30, width: 30,) : null,
          isThreeLine: true,
        ),
      ),
    );
  }
}
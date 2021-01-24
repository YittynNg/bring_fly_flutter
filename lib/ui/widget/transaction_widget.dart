import 'package:bringfly_uniwallet/model/transaction.dart';
import 'package:bringfly_uniwallet/ui/constant/logo.dart';
import 'package:bringfly_uniwallet/ui/page/account/account_page.dart';
import 'package:flutter/material.dart';

class TransactionWidget extends StatelessWidget{

  final Transaction transaction;
  final bool logo;

  TransactionWidget(this.transaction, {this.logo = false});

  AssetImage _typeToImage(String type) {
    switch(type) {
      case 'Digi':
        return DigiLogo;
      case 'Celcom':
        return CelcomLogo;
      case 'Maxis':
        return MaxisLogo;
      case 'UMobile':
        return UMobileLogo;
      case 'TuneTalk':
        return TuneTalkLogo;
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
        child: Row(
          children: [
            if(logo) Image(image: _typeToImage(transaction.account.type), height: 40, width: 70,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${transaction.title}', style: Theme.of(context).textTheme.subtitle1,),
                  Text('${transaction.time}', style: Theme.of(context).textTheme.overline,),
                ],
              ),
            ),
            Text(transaction.amount.toStringAsFixed(2), style: TextStyle(color: transaction.amount > 0? Colors.green : Colors.red),)
          ],
        ),
      ),
    );
  }
}
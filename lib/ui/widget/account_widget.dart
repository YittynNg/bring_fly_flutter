import '../../model/account.dart';
import '../constant/logo.dart';
import 'package:flutter/material.dart';

class MyAccountCard extends StatelessWidget{

  final Function() _onTap;
  final String type;
  final String name;
  final Account account;
  MyAccountCard(this._onTap, {this.type = '', this.name = '', this.account});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: InkWell(
        onTap: _onTap,
        child: Card(
          elevation: 3,
          child: Container(
            height: 60,
            padding: EdgeInsets.all(9),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Image(image: _typeToImage(account?.type),),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Balance', style: Theme.of(context).textTheme.overline,),
                      Text('RM '+account.balance.toStringAsFixed(2), style: Theme.of(context).textTheme.bodyText1,)
                    ],
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AccountCard extends StatelessWidget{

  final Function() _onTap;
  final String type;
  final String name;
  AccountCard(this._onTap, {this.type='', this.name=''});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: InkWell(
        onTap: _onTap,
        child: Card(
          elevation: 3,
          child: Container(
            height: 60,
            padding: EdgeInsets.all(9),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Image(image: _typeToImage(type),),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(name)
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
    case 'Maybank':
      return MaybankLogo;
    case 'CIMB':
      return CIMBLogo;
    case 'PBBank':
      return PBBankLogo;
    case 'HLBank':
      return HLBankLogo;
    default:
      return DuitNowQR;
  }
}

DropdownMenuItem<Account> AccountDropDownMenuItem(Account account) => DropdownMenuItem(
  value: account,
  child: SizedBox(
    width: 240,
    child: Row(
      children: [
        Image(image: _typeToImage(account.type), height: 40, width: 80,),
        SizedBox(width: 9,),
        Expanded(
          child: SizedBox(),
        ),
        Padding(
          padding: const EdgeInsets.all(9.0),
          child: Text('RM'+account.balance.toStringAsFixed(2)),
        )
      ],
    ),
  ),
);

DropdownMenuItem<String> AccountTypeDropDownMenuItem(String account) => DropdownMenuItem(
  value: account,
  child: SizedBox(
    width: 220,
    child: Row(
      children: [
        Image(image: _typeToImage(account), height: 40, width: 80,),
        SizedBox(width: 9,),
        Text(account)
      ],
    ),
  ),
);
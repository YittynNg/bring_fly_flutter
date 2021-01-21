import 'package:bringfly_uniwallet/ui/constant/logo.dart';
import 'package:bringfly_uniwallet/ui/page/account/account_page.dart';
import 'package:flutter/material.dart';

class MyAccountCard extends StatelessWidget{

  final Function() _onTap;
  final String type;
  final String name;
  MyAccountCard(this._onTap, {this.type = '', this.name = ''});
  
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Balance', style: Theme.of(context).textTheme.overline,),
                      Text('RM 1000.00', style: Theme.of(context).textTheme.bodyText1,)
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
    default:
      return GrabPayLogo;
  }
}

DropdownMenuItem<String> AccountDropDownMenuItem(String value, double amount) => DropdownMenuItem(
  value: value,
  child: SizedBox(
    width: 240,
    child: Row(
      children: [
        Image(image: _typeToImage(value), height: 40, width: 80,),
        SizedBox(width: 9,),
        Expanded(
          child: SizedBox(),
        ),
        Padding(
          padding: const EdgeInsets.all(9.0),
          child: Text('RM'+amount.toStringAsFixed(2)),
        )
      ],
    ),
  ),
);
import 'package:bringfly_uniwallet/ui/constant/logo.dart';
import 'package:bringfly_uniwallet/ui/page/account/account_page.dart';
import 'package:flutter/material.dart';

class MyAccountCard extends StatelessWidget{

  final Function() _onTap;
  MyAccountCard(this._onTap);
  
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
                    child: Image(image: GrabPayLogo,),
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
  AccountCard(this._onTap);
  
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
                    child: Image(image: GrabPayLogo,),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text('GrabPay')
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
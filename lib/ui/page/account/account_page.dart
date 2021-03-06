import 'package:bringfly_uniwallet/model/account.dart';
import 'package:bringfly_uniwallet/ui/page/account/account_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../widget/transactions_history_list.dart';

import '../../common/appBar.dart';
import '../../constant/logo.dart';
import 'package:flutter/material.dart';

import 'top_up_page.dart';

class AccountPageView extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final Account account;
  AccountPageView({this.account});

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

  @override
  Widget build(BuildContext context) {

    _goToTopUpPage() async {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => TopUpPageView(account)));
    }

    _showTransactionsHistory() async {
      showModalBottomSheet(context: context, builder: (context) => TransactionsHistoryList(account));
      // _scaffoldKey.currentState.showBottomSheet((context) => TransactionsHistoryList());
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: TransparentAppBar(context),
      body: ViewModelBuilder<AccountViewModel>.reactive(
        viewModelBuilder: () => AccountViewModel(account),
        builder: (context, model, _) {
          return Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      height: 150, width: 300,
                      image: _typeToImage(account.type),
                    ),
                    SizedBox(height: 9,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Balance: '),
                        Text('RM'+model.acc.balance.toStringAsFixed(2), style: Theme.of(context).textTheme.headline6),
                      ],
                    ),
                    SizedBox(height: 9,),
                    ElevatedButton(
                      onPressed: _goToTopUpPage, 
                      child: Text('Top Up')
                    ),

                    SizedBox(height: 60,),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: model.removeAccount, 
                    child: Text('Remove Account')
                  ),
                  SizedBox(width: 9,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    onPressed: _showTransactionsHistory, 
                    child: Text('Transaction History')
                  ),
                ],
              ),
              SizedBox(height: 9),
            ],
          );
        }
      ),
    );
  }
}
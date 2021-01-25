import 'package:bringfly_uniwallet/common/mock_data.dart';
import 'package:bringfly_uniwallet/locator.dart';
import 'package:bringfly_uniwallet/model/account.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../account/account_page.dart';
import '../../widget/add_account_dialog.dart';

import '../../widget/account_widget.dart';

import '../../widget/drawer.dart';
import 'package:flutter/material.dart';

import 'home_viewmodel.dart';

class Home extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    HomeViewModel _model = HomeViewModel();

    _addWallet() async {
      bool added = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AddAccountDialog(type: "E-Wallet",);
        }
      );
      print('From AddAccountDialog: $added');
      if(added != null && added) {
        locator<DialogService>().showDialog(description: 'Account is added.');
        _model.notifyListeners();
      }
    }

    _addBank() async {
      bool added = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AddAccountDialog(type: "Bank",);
        }
      );
      print('From AddAccountDialog: $added');
      if(added != null && added) {
        locator<DialogService>().showDialog(title: 'Success', description: 'Account is added.');
        _model.notifyListeners();
      }
    }

    _goToAccountPage(Account account) async {
      await Navigator.of(context).push(MaterialPageRoute(builder: (context) => AccountPageView(account: account)));
      _model.notifyListeners();
    }

    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => _model,
      onModelReady: (model) => model.init(),
      builder: (context, model, _) {
        return Scaffold(
          key: _scaffoldKey,
          drawer: MyDrawer(),
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
              },
            ),
          ),
          body: Column(
            children: [
              Container(
                height: 200,
                color: Theme.of(context).primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('RM '+model.totalBalance().toStringAsFixed(2), style: Theme.of(context).textTheme.headline2.copyWith(color: Colors.white),),
                    Text('Current Balance', style: Theme.of(context).textTheme.overline.copyWith(color: Colors.white),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: _addWallet, 
                          child: Text('Add Wallet')
                        ),
                        SizedBox(width: 6,),
                        ElevatedButton(
                          onPressed: _addBank, 
                          child: Text('Add Bank')
                        ),
                        SizedBox(width: 6,),
                        ElevatedButton(
                          onPressed: null, 
                          child: Text('Add Card')
                        )
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 5,),
                      for(var acc in model.accounts)
                        MyAccountCard(() => _goToAccountPage(acc), account: acc,),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }
    );
  }
}
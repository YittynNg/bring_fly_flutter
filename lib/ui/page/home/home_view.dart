import '../account/account_page.dart';
import '../../widget/add_account_dialog.dart';

import '../../widget/account_card.dart';

import '../../widget/drawer.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    _addWallet() {
      showDialog(
        context: context,
        builder: (context) {
          return AddAccountDialog();
        }
      );
    }

    _goToAccountPage() {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AccountPageView()));
    }

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
                Text('RM 10,650.33', style: Theme.of(context).textTheme.headline2.copyWith(color: Colors.white),),
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
                      onPressed: null, 
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
                  MyAccountCard(_goToAccountPage),
                  MyAccountCard(_goToAccountPage),
                  MyAccountCard(_goToAccountPage)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
import 'package:bringfly_uniwallet/common/mock_data.dart';
import 'package:bringfly_uniwallet/service/accounts_service.dart';
import 'package:bringfly_uniwallet/ui/widget/account_widget.dart';
import 'package:bringfly_uniwallet/ui/widget/account_qr.dart';
import 'package:flutter/material.dart';
import '../../../locator.dart';
import '../../constant/logo.dart';

class PayWithQRPageView extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    PersistentBottomSheetController _bottomSheetController;

    _showQRWidget() async {
      // showModalBottomSheet(context: context, builder: (context) => TransactionsHistoryList());
      _bottomSheetController?.close();
      _bottomSheetController = _scaffoldKey.currentState.showBottomSheet((context) => AccountQRWidget());
    }
    
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Receive Payment'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5,),
            for(var acc in locator<AccountService>().accounts)
              MyAccountCard(_showQRWidget, account: acc,),
          ],
        ),
      ),
    );
  }
}
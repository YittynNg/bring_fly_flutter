import 'package:bringfly_uniwallet/ui/widget/account_card.dart';
import 'package:bringfly_uniwallet/ui/widget/account_qr.dart';
import 'package:flutter/material.dart';
import '../../constant/logo.dart';

class ReceiveWithQRPageView extends StatelessWidget {

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
            MyAccountCard(_showQRWidget),
            MyAccountCard(_showQRWidget),
            MyAccountCard(_showQRWidget)
          ],
        ),
      ),
    );
  }
}
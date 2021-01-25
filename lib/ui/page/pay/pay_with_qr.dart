import 'package:bringfly_uniwallet/common/mock_data.dart';
import 'package:bringfly_uniwallet/model/promotion.dart';
import 'package:bringfly_uniwallet/service/accounts_service.dart';
import 'package:bringfly_uniwallet/service/promotion_service.dart';
import 'package:bringfly_uniwallet/ui/widget/account_widget.dart';
import 'package:bringfly_uniwallet/ui/widget/account_qr.dart';
import 'package:bringfly_uniwallet/ui/widget/promotion_widget.dart';
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
      try {
        _bottomSheetController?.close();
      } catch(e) {}
      _bottomSheetController = _scaffoldKey.currentState.showBottomSheet((context) => AccountQRWidget());
    }

    _searchForMerchant() async {
      showDialog(
        context: context,
        builder: (context) {
          return _SearchMerchantPromotionDialog();
        }
      );
    }
    
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Pay Payment'),
        actions: [
          IconButton(
            icon: Icon(Icons.search), 
            onPressed: _searchForMerchant
          )
        ],
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

class _SearchMerchantPromotionDialog extends StatefulWidget {
  @override
  _SearchMerchantPromotionDialogState createState() {
    return _SearchMerchantPromotionDialogState();
  }
}

class _SearchMerchantPromotionDialogState extends State<_SearchMerchantPromotionDialog> {

  GlobalKey<ScaffoldState> _formKey = GlobalKey();
  TextEditingController _text = TextEditingController();
  FocusNode _textFocusNode = FocusNode();
  bool loading = false;

  _textEditingCompleted() async {
    FocusScope.of(context).unfocus();
    setState(() {
      loading = true;
    });
    var result = await locator<PromotionService>().filterMerchant(_text.text);
    setState(() {
      promotions = result;
      loading = false;
    });
  }

  List<Promotion> promotions = [];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(12),
        height: 400,
        child: Column(
          children: [
            Text('Search Merchant', style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 6),
            Form(
              key: _formKey,
              child: TextFormField(
                // enabled: model.isBusy ? false : true,
                controller: _text,
                focusNode: _textFocusNode,
                textInputAction: TextInputAction.search,
                onEditingComplete: () =>
                    _textEditingCompleted(),
                cursorColor: Colors.black,
                autocorrect: false,
                decoration: InputDecoration(
                  filled: true,
                  labelText: "Merchant",
                ),
              ),
            ),
            SizedBox(height: 6,),
            Expanded(
              child: loading
                ? Center(
                  child: SizedBox(
                    height: 40, width: 40,
                    child: CircularProgressIndicator(),
                  ),
                )
                : promotions.length > 0
                  ? ListView(
                    children: [
                      for(var promotion in promotions)
                        PromotionWidget(promotion,),
                    ],
                  )
                  : Center(
                    child: Text('No Promotions'),
                  ),
            )
          ],
        ),
      ),
    );
  }
}
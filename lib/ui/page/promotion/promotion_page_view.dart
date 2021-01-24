import 'package:bringfly_uniwallet/locator.dart';
import 'package:bringfly_uniwallet/model/account.dart';
import 'package:bringfly_uniwallet/service/accounts_service.dart';
import 'package:bringfly_uniwallet/ui/page/promotion/promotion_viewmodel.dart';
import 'package:bringfly_uniwallet/ui/page/transaction/transaction_history_viewmodel.dart';
import 'package:bringfly_uniwallet/ui/widget/account_widget.dart';
import 'package:bringfly_uniwallet/ui/widget/promotion_widget.dart';
import 'package:bringfly_uniwallet/ui/widget/transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PromotionPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PromotionHistoryViewModel>.reactive(
      viewModelBuilder: () => PromotionHistoryViewModel(),
      builder: (context, model, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Transactions'),
            actions: [
              IconButton(
                icon: Icon(Icons.more_vert), 
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return _FilterDialog(model);
                    }
                  );
                }
              )
            ],
          ),
          body: model.isBusy
            ? Center(
              child: SizedBox(
                height: 40, width: 40,
                child: CircularProgressIndicator(),
              ),
            )
            : model.promotions.length > 0
              ? SingleChildScrollView(
                child: Column(
                  children: [
                    for(var promotion in model.promotions)
                      PromotionWidget(promotion),
                    SizedBox(height: 9,)
                  ],
                ),
              )
              : Center(
                child: Text('No promotion'),
              )
        );
      }
    );
  }
}

class _FilterDialog extends StatelessWidget {

  final PromotionHistoryViewModel model;

  _FilterDialog(this.model);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(12),
        height: 300,
        child: Column(
          children: [
            Text('Filter', style: Theme.of(context).textTheme.headline6,),
            SizedBox(height: 12,),
            StatefulBuilder(
              builder: (context, setState) {
                return DropdownButton<String>(
                  value: model.account,
                  onChanged: (value) {
                    setState(() {
                      model.account = value;
                      model.filter();
                    });
                  },
                  hint: Text('All accounts'),
                  items: [
                    DropdownMenuItem(
                      value: null,
                      child: SizedBox(
                        width: 240,
                        child: Row(
                          children: [
                            SizedBox(width: 9,),
                            Expanded(
                              child: SizedBox(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: Text('All accounts'),
                            )
                          ],
                        ),
                      ),
                    ),
                    for(var account in Accounts)
                      AccountTypeDropDownMenuItem(account),
                  ]
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
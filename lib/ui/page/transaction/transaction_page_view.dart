import 'package:bringfly_uniwallet/locator.dart';
import 'package:bringfly_uniwallet/model/account.dart';
import 'package:bringfly_uniwallet/service/accounts_service.dart';
import 'package:bringfly_uniwallet/ui/page/transaction/transaction_history_viewmodel.dart';
import 'package:bringfly_uniwallet/ui/widget/account_widget.dart';
import 'package:bringfly_uniwallet/ui/widget/transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TransactionPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TransactionHistoryViewModel>.reactive(
      viewModelBuilder: () => TransactionHistoryViewModel(),
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
            : SingleChildScrollView(
              child: Column(
                children: [
                  for(var transaction in model.transactions)
                    TransactionWidget(transaction, logo: true,),
                  SizedBox(height: 9,)
                ],
              ),
            )
        );
      }
    );
  }
}

class _FilterDialog extends StatelessWidget {

  final TransactionHistoryViewModel model;

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
                return DropdownButton<Account>(
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
                    for(var account in locator<AccountService>().accounts)
                      AccountDropDownMenuItem(account),
                  ]
                );
              }
            ),
            
            StatefulBuilder(
              builder: (context, setState) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('From: ${model.from}'),
                    IconButton(
                      icon: Icon(Icons.calendar_today), 
                      onPressed: () async {
                        var time = await showDatePicker(context: context, initialDate: model.from, firstDate: DateTime(2000), lastDate: DateTime.now());
                        if(time != null) {
                          setState(() {
                            model.from = time;
                            model.filter();
                          });
                        }
                      }
                    )
                  ],
                );
              }
            ),

            StatefulBuilder(
              builder: (context, setState) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('To: ${model.to}'),
                    IconButton(
                      icon: Icon(Icons.calendar_today), 
                      onPressed: () async {
                        var time = await showDatePicker(context: context, initialDate: model.to, firstDate: DateTime(2000), lastDate: DateTime.now());
                        if(time != null) {
                          setState(() {
                            model.to = time;
                            model.filter();
                          });
                        }
                      }
                    )
                  ],
                );
              }
            ),

            Expanded(
              child: SizedBox(),
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     ElevatedButton(onPressed: () {

            //     }, child: Text('Okay'))
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
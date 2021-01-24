import 'package:bringfly_uniwallet/ui/page/transaction/transaction_history_viewmodel.dart';
import 'package:bringfly_uniwallet/ui/widget/transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TransactionPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: ViewModelBuilder<TransactionHistoryViewModel>.reactive(
        viewModelBuilder: () => TransactionHistoryViewModel(),
        builder: (context, model, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 9,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Transaction History', style: Theme.of(context).textTheme.headline6),
                  Icon(Icons.keyboard_arrow_down)
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for(var transaction in model.transactions)
                        TransactionWidget(transaction),
                      SizedBox(height: 9,)
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
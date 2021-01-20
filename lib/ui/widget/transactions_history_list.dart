import 'package:bringfly_uniwallet/ui/widget/transaction_widget.dart';
import 'package:flutter/material.dart';

class TransactionsHistoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      type: MaterialType.card,
      child: Container(
        height: 300,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Column(
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
                      TransactionWidget(),
                      TransactionWidget(),
                      TransactionWidget(),
                      TransactionWidget(),
                      TransactionWidget(),
                      TransactionWidget(),
                      TransactionWidget(),
                      TransactionWidget(),
                      SizedBox(height: 9,)
                    ],
                  ),
                ),
              ),
              // TransactionWidget(),
              // TransactionWidget(),
              // TransactionWidget(),
              // TransactionWidget(),
              // TransactionWidget(),
              // TransactionWidget(),
              // TransactionWidget(),
              // TransactionWidget(),
              // SizedBox(height: 9,)
            ],
          ),
        ),
      ),
    );
  }
}
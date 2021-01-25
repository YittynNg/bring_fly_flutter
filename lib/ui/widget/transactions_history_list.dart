import 'package:bringfly_uniwallet/locator.dart';
import 'package:bringfly_uniwallet/model/account.dart';
import 'package:bringfly_uniwallet/service/accounts_service.dart';
import 'package:bringfly_uniwallet/ui/widget/transaction_widget.dart';
import 'package:flutter/material.dart';

class TransactionsHistoryList extends StatelessWidget {

  final Account account;

  TransactionsHistoryList(this.account);
  

  @override
  Widget build(BuildContext context) {

    var transactions = locator<AccountService>().getTransactionsOf(account);

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
                child: transactions.length <= 0
                  ? Center(
                    child: Text('No transactions'),
                  )
                  : SingleChildScrollView(
                    child: Column(
                      children: [
                        for(var transaction in transactions)
                          TransactionWidget(transaction),
                        SizedBox(height: 9,)
                      ],
                    ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
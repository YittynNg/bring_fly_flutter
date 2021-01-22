import 'package:bringfly_uniwallet/common/mock_data.dart';
import 'package:bringfly_uniwallet/model/accounts.dart';
import 'package:bringfly_uniwallet/ui/widget/account_widget.dart';
import 'package:bringfly_uniwallet/util/validator.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'swap_balance_viewmodel.dart';

class SwapBalancePageView extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final FocusNode _amountFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {

    _amountEditingComplete() {}
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Swap Balance'),
      ),
      body: ViewModelBuilder<SwapBalanceViewModel>.reactive(
        viewModelBuilder: () => SwapBalanceViewModel(), 
        builder: (context, model, _) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 9),
                      child: Text('From'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 9),
                      child: StatefulBuilder(
                        builder: (context, setState) {
                          return DropdownButton<Account>(
                            onChanged: (value) {
                              setState(() { model.accFrom = value; });
                              model.notifyListeners();
                            },
                            value: model.accFrom,
                            hint: Text('Choose Wallet'),
                            items: [
                              for(var acc in MockData.accounts)
                                AccountDropDownMenuItem(acc)
                            ],
                          );
                        }
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12,),
                if(model.accFrom != null)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 9),
                        child: Text('To'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 9),
                        child: StatefulBuilder(
                          builder: (context, setState) {
                            return DropdownButton<Account>(
                              onChanged: (value) {
                                setState(() { model.accTo = value; });
                                model.notifyListeners();
                              },
                              value: model.accTo,
                              hint: Text('Choose Wallet'),
                              items: [
                                for(var acc in MockData.accounts)
                                  AccountDropDownMenuItem(acc)
                              ],
                            );
                          }
                        ),
                      ),
                    ],
                  ),
                if(model.accTo != null)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Enter Amount'),
                        Form(
                          key: _formKey,
                          child: TextFormField(
                            // enabled: model.isBusy ? false : true,
                            controller: model.amountTextController,
                            focusNode: _amountFocusNode,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () =>
                                _amountEditingComplete(),
                            keyboardType: TextInputType.numberWithOptions(
                              decimal: true
                            ),
                            cursorColor: Colors.black,
                            validator: Validator.amountValidator,
                            autocorrect: false,
                            decoration: InputDecoration(
                              fillColor: Colors.grey[100],
                              filled: true,
                              labelText: "Amount",
                              labelStyle: TextStyle(
                                  color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                if(model.accTo != null)
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.green),
                          onPressed: () {}, 
                          child: Text('Confirm')
                        )
                      ],
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
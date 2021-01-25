import 'package:bringfly_uniwallet/common/mock_data.dart';
import 'package:bringfly_uniwallet/model/account.dart';
import 'package:bringfly_uniwallet/service/accounts_service.dart';
import 'package:bringfly_uniwallet/ui/widget/account_widget.dart';
import 'package:bringfly_uniwallet/util/validator.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../locator.dart';
import 'swap_balance_viewmodel.dart';

class SwapBalancePageView extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final FocusNode _amountFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Swap Balance'),
      ),
      body: ViewModelBuilder<SwapBalanceViewModel>.reactive(
        viewModelBuilder: () => SwapBalanceViewModel(), 
        builder: (context, model, _) {

          _amountEditingComplete() async {
            if(_formKey.currentState.validate()) {
              FocusScope.of(context).unfocus();
              var result = await locator<DialogService>().showConfirmationDialog(title: 'Swap Balance', description: 'Are you sure wanna swap balance?', confirmationTitle: 'Proceed');
              if(result.confirmed) {
                await model.swap();
              }
            }
          }

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
                              for(var acc in locator<AccountService>().accounts)
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
                                for(var acc in locator<AccountService>().accounts)
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
                              filled: true,
                              labelText: "Amount",
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                SizedBox(
                  height: 40,
                  child: Text(model.accFrom == model.accTo && model.accTo != null? 'Choose a different account' : '', style: TextStyle(color: Colors.red),),
                ),
                if(model.accTo != null)
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        model.isBusy
                          ? SizedBox(
                            height: 40, width: 40,
                            child: CircularProgressIndicator(),
                          )
                          : ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: Colors.green),
                            onPressed: _amountEditingComplete, 
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
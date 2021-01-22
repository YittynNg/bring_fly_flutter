import 'dart:math';

import 'package:bringfly_uniwallet/common/mock_data.dart';
import 'package:bringfly_uniwallet/locator.dart';
import 'package:bringfly_uniwallet/model/accounts.dart';
import 'package:bringfly_uniwallet/ui/constant/logo.dart';
import 'package:bringfly_uniwallet/ui/page/verify/verification_page_view.dart';
import 'package:bringfly_uniwallet/util/validator.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'account_widget.dart';

class AddAccountDialog extends StatelessWidget {
  
  final String type;
  AddAccountDialog({this.type});

  final TextEditingController _phone = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<AddAccountDialogViewmodel>.reactive(
      viewModelBuilder: () => AddAccountDialogViewmodel(),
      builder: (context, model, _) {

        _phoneEditingComplete() async {
          if (_formKey.currentState.validate()) {
            FocusScope.of(context).unfocus();
            // await model.checkCanSignIn(_email.text, _password.text);
            // Navigator.pushNamed(context, RootPageRoute);
            await model.requestAddAccount();
            // bool result = await Navigator.of(context).push<bool>(MaterialPageRoute(builder: (context) {
            //   return VerificationPage(phone: '+6'+_phone.text,);
            // }));
            // print('From verification: $result');
            // if(result != null && result) {
            //   Navigator.of(context).pop(true);
            // }
          }
        }

        return SimpleDialog(
          contentPadding: EdgeInsets.symmetric(vertical: 9, horizontal: 15),
          title: Text('Add E-Wallet'),
          children: [
            StatefulBuilder(
              builder: (context, setState) {

                _changeAccount(String value) {
                  model.changeAccount(value);
                  setState((){});
                }

                return DropdownButton<String>(
                  onChanged: _changeAccount,
                  value: model.account,
                  hint: Text('Choose Wallet'),
                  items: [
                    AccountTypeDropDownMenuItem('TouchNGo'),
                    AccountTypeDropDownMenuItem('GrabPay'),
                    AccountTypeDropDownMenuItem('Boost'),
                    // DropdownMenuItem(
                    //   value: 'TouchNGo',
                    //   child: Row(
                    //     children: [
                    //       Image(image: TouchNGoLogo, height: 40, width: 80,),
                    //       SizedBox(width: 9,),
                    //       Text('TouchNGo')
                    //     ],
                    //   ),
                    // ),
                    // DropdownMenuItem(
                    //   value: 'GrabPay',
                    //   child: Row(
                    //     children: [
                    //       Image(image: GrabPayLogo, height: 40, width: 80,),
                    //       SizedBox(width: 9,),
                    //       Text('TouchNGo')
                    //     ],
                    //   ),
                    // ),
                    // DropdownMenuItem(
                    //   value: 'Boost',
                    //   child: Row(
                    //     children: [
                    //       Image(image: BoostLogo, height: 40, width: 80,),
                    //       SizedBox(width: 9,),
                    //       Text('TouchNGo')
                    //     ],
                    //   ),
                    // )
                  ],
                );
              }
            ),

            SizedBox(height: 9,),

            Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 9
                ),
                child: TextFormField(
                  enabled: model.isBusy ? false : true,
                  controller: model.phone,
                  focusNode: _phoneFocusNode,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () =>
                      _phoneEditingComplete(),
                  keyboardType: TextInputType.phone,
                  cursorColor: Colors.black,
                  validator: Validator.mobileValidator,
                  autocorrect: false,
                  decoration: InputDecoration(
                    fillColor: Colors.grey[100],
                    filled: true,
                    labelText: "Phone",
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
                )
              )
            ),

            Text('By proceed, you argee with the Term and Condition'),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  }, 
                  child: Text('Cancel')
                ),
                SizedBox(width: 9,),
                ElevatedButton(
                  onPressed: _phoneEditingComplete, 
                  child: Text('Next')
                )
              ],
            ),
          ],
        );
      }
    );
  }
}

class AddAccountDialogViewmodel extends BaseViewModel {
  final String type;
  String account;

  AddAccountDialogViewmodel({this.type});

  final TextEditingController phone = TextEditingController();

  changeAccount(String value) {
    account = value;
  }

  Future<void> requestAddAccount() async {
    bool result = await locator<NavigationService>().navigateToView(VerificationPage(phone: '+6'+phone.text,));
    print('From verification: $result');
    if(result != null && result) {
      MockData.accounts.add(Account(type: account, balance: Random.secure().nextInt(1000).toDouble()));
      locator<NavigationService>().back(result: true);
    }
  }
}
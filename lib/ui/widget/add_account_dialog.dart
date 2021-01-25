import 'dart:math';

import 'package:bringfly_uniwallet/common/mock_data.dart';
import 'package:bringfly_uniwallet/locator.dart';
import 'package:bringfly_uniwallet/model/account.dart';
import 'package:bringfly_uniwallet/service/accounts_service.dart';
import 'package:bringfly_uniwallet/ui/constant/logo.dart';
import 'package:bringfly_uniwallet/ui/page/Term&Condition_page.dart';
import 'package:bringfly_uniwallet/ui/page/verify/verification_page_view.dart';
import 'package:bringfly_uniwallet/ui/utils/LoadingPage.dart';
import 'package:bringfly_uniwallet/util/validator.dart';
import 'package:flutter/gestures.dart';
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
      viewModelBuilder: () => AddAccountDialogViewmodel(type),
      builder: (context, model, _) {

        _phoneEditingComplete() async {
          if(type == "E-Wallet") {
            if (_formKey.currentState.validate()) {
              FocusScope.of(context).unfocus();
              await model.requestAddAccount();
            }
          } else {
            await model.requestAddAccount();
          }
        }

        return SimpleDialog(
          contentPadding: EdgeInsets.symmetric(vertical: 9, horizontal: 15),
          title: Text('Add $type'),
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
                  hint: Text('Choose $type'),
                  items: type == "E-Wallet"? [
                    AccountTypeDropDownMenuItem('TouchNGo'),
                    AccountTypeDropDownMenuItem('GrabPay'),
                    AccountTypeDropDownMenuItem('Boost'),
                  ] : [
                    AccountTypeDropDownMenuItem("Maybank"),
                    AccountTypeDropDownMenuItem("CIMB"),
                    AccountTypeDropDownMenuItem("PBBank"),
                    AccountTypeDropDownMenuItem("HLBank"),
                    AccountTypeDropDownMenuItem("Others"),
                  ],
                );
              }
            ),

            SizedBox(height: 9,),

            if(type == "E-Wallet") Form(
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
                    filled: true,
                    labelText: "Phone",
                  ),
                )
              )
            ),

            RichText(
              text: TextSpan(
                text: "By proceed, you argee with the ",
                children: [
                  TextSpan(
                    text: "Terms and Conditions",
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()..onTap = model.goTNC,
                  )
                ]
              ),
            ),

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

  AddAccountDialogViewmodel(this.type);

  final TextEditingController phone = TextEditingController();

  changeAccount(String value) {
    account = value;
  }

  Future<void> requestAddAccount() async {
    bool result;
    if(type == 'E-Wallet') {
      result = await locator<NavigationService>().navigateToView(VerificationPage(phone: '+6'+phone.text,));
      print('From verification: $result');
    } else {
      locator<NavigationService>().navigateToView(LoadingPage(message: 'Request authorization from bank...',));
      await Future.delayed(Duration(seconds: 2));
      locator<NavigationService>().back();
      result = true;
    }
    if(result != null && result) {
      await locator<AccountService>().addAccount(Account(type: account, balance: Random.secure().nextInt(1000).toDouble(), phone: '+6'+phone.text));
      locator<NavigationService>().back(result: true);
    }
  }

  goTNC() {
    locator<NavigationService>().navigateToView(TermNConditionView());
  }
}
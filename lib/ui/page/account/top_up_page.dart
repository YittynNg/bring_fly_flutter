import 'package:bringfly_uniwallet/locator.dart';
import 'package:bringfly_uniwallet/model/account.dart';
import 'package:bringfly_uniwallet/service/accounts_service.dart';
import 'package:bringfly_uniwallet/util/validator.dart';

import '../../common/appBar.dart';
import '../../constant/logo.dart';
import 'package:flutter/material.dart';

class TopUpPageView extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _amount = TextEditingController();//..text = '000000';
  final FocusNode _amountFocusNode = FocusNode();

  final Account account;

  TopUpPageView(this.account);

  @override
  Widget build(BuildContext context) {

    bool _amountEditingComplete() {
      if(_formKey.currentState.validate()) {
        FocusScope.of(context).unfocus();
        return true;
      }
      return false;
      // check payment gateway
    }

    Future<void> _submit() async {
      if(_formKey.currentState.validate()) {
        FocusScope.of(context).unfocus();
        await locator<AccountService>().topUp(account, double.parse(_amount.text));
        Navigator.of(context).pop(true);
      }
    }

    AssetImage _typeToImage(String type) {
      switch(type) {
        case 'TouchNGo':
          return TouchNGoLogo;
        case 'Boost':
          return BoostLogo;
        case 'GrabPay':
          return GrabPayLogo;
        default:
          return DuitNowQR;
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: TransparentAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image(
                    height: 150, width: 300,
                    image: _typeToImage(account.type),
                  ),
                  SizedBox(height: 9,),
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
                            controller: _amount,
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
                              fillColor: Theme.of(context).brightness == Brightness.light? Colors.grey[100] : Colors.grey[800],
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
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Payment Method'),
                        Container(width: double.infinity,)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.green),
            onPressed: _submit, 
            child: Text('Confirm')
          ),
          SizedBox(height: 9),
        ],
      ),
    );
  }
}
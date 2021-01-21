import 'package:bringfly_uniwallet/ui/widget/account_widget.dart';
import 'package:bringfly_uniwallet/util/validator.dart';
import 'package:flutter/material.dart';

class TelcoBillPageView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    _onTap() {
      // showModalBottomSheet(context: context, builder: (context) {
      //   return _BottomSheetForm();
      // });

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return _BottomSheetForm();
          },
        fullscreenDialog: true
      ));

      // showDialog(
      //   context: context,
      //   builder: (context) {
      //     return _BottomSheetForm();
      //   }
      // );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Telco Prepaid'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AccountCard(_onTap, type: 'Digi', name: 'Digi',),
            AccountCard(_onTap, type: 'Celcom', name: 'Celcom',),
            AccountCard(_onTap, type: 'Maxis', name: 'Maxis',),
            AccountCard(_onTap, type: 'UMobile', name: 'UMobile',),
            AccountCard(_onTap, type: 'TuneTalk', name: 'TuneTalk',)
          ],
        ),
      ),
    );
  }
}

class _BottomSheetForm extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _number = TextEditingController();//..text = '000000';
  final FocusNode _numberFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {

    _numberEditingComplete() {
      if(_formKey.currentState.validate()) {
        FocusScope.of(context).unfocus();
      }
    }

    Function(void Function()) setErrorState;
    String errorText = '';

    int amount = 30;
    String account;

    _submit() {
      if(_formKey.currentState.validate()) {
        FocusScope.of(context).unfocus();
        if(amount == null) {
          setErrorState(() {
            errorText = 'Please select amount';
          });
          return;
        }
        if(account == null) {
          setErrorState(() {
            errorText = 'Please select account to pay';
          });
          return;
        }
      }
      setErrorState(() {
        errorText = '';
      });
    }

    return Material(
      elevation: 3,
      type: MaterialType.card,
      child: Scaffold(
        // height: 400,
        // width: MediaQuery.of(context).size.width,
        appBar: AppBar(
          title: Text('Top Up'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 9),
                height: 100,
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    // enabled: model.isBusy ? false : true,
                    controller: _number,
                    focusNode: _numberFocusNode,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () =>
                        _numberEditingComplete(),
                    keyboardType: TextInputType.phone,
                    cursorColor: Colors.black,
                    validator: Validator.mobileValidator,
                    autocorrect: false,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[100],
                      filled: true,
                      labelText: "Mobile Number",
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
                ),
              ),

              SizedBox(height: 9,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9),
                child: Text('From'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9),
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return DropdownButton<String>(
                      onChanged: (value) {
                        setState(() { account = value; });
                      },
                      value: account,
                      hint: Text('Choose Wallet'),
                      items: [
                        AccountDropDownMenuItem('TouchNGo', 1000),
                        AccountDropDownMenuItem('GrabPay', 1000),
                        AccountDropDownMenuItem('Boost', 1000),
                      ],
                    );
                  }
                ),
              ),

              SizedBox(height: 9,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9),
                child: Text('Amount'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9),
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return DropdownButton<int>(
                      onChanged: (value) {
                        setState(() { amount = value; });
                      },
                      value: amount,
                      hint: Text('Choose Wallet'),
                      items: [
                        DropdownMenuItem(
                          value: 100,
                          child: Text('RM100'),
                        ),
                        DropdownMenuItem(
                          value: 50,
                          child: Text('RM50'),
                        ),
                        DropdownMenuItem(
                          value: 30,
                          child: Text('RM30'),
                        ),
                        DropdownMenuItem(
                          value: 10,
                          child: Text('RM10'),
                        ),
                        DropdownMenuItem(
                          value: 5,
                          child: Text('RM5'),
                        )
                      ],
                    );
                  }
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(9.0),
                child: StatefulBuilder(
                  builder: (context, setState) {
                    setErrorState = setState;
                    return SizedBox(
                      height: 30,
                      child: Text(errorText, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                    );
                  }
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(9.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                      onPressed: _submit, 
                      child: Text('Confirm')
                    )
                  ],
                ),
              )
            ],  
          ),
        ),
      ),
    );
  }
}
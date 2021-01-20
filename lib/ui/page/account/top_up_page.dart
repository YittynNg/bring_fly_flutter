import 'package:bringfly_uniwallet/util/validator.dart';

import '../../common/appBar.dart';
import '../../constant/logo.dart';
import 'package:flutter/material.dart';

class TopUpPageView extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _amount = TextEditingController();//..text = '000000';
  final FocusNode _amountFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {

    _amountEditingComplete() async {
      if(_formKey.currentState.validate()) {
        FocusScope.of(context).unfocus();
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
                    image: GrabPayLogo,
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
            onPressed: () {}, 
            child: Text('Confirm')
          ),
          SizedBox(height: 9),
        ],
      ),
    );
  }
}
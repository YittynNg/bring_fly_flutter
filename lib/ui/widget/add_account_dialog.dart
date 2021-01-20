import 'package:bringfly_uniwallet/ui/constant/logo.dart';
import 'package:bringfly_uniwallet/util/validator.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AddAccountDialog extends StatelessWidget {
  
  final String type;
  AddAccountDialog({this.type});

  final TextEditingController _phone = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    _phoneEditingComplete() async {
      if (_formKey.currentState.validate()) {
        FocusScope.of(context).unfocus();
        // await model.checkCanSignIn(_email.text, _password.text);
        // Navigator.pushNamed(context, RootPageRoute);
      }
    }

    return ViewModelBuilder<AddAccountDialogViewmodel>.reactive(
      viewModelBuilder: () => AddAccountDialogViewmodel(),
      builder: (context, model, _) {
        return SimpleDialog(
          contentPadding: EdgeInsets.symmetric(vertical: 9, horizontal: 15),
          title: Text('Add E-Wallet'),
          children: [
            DropdownButton<String>(
              onChanged: (value) {},
              value: null,
              hint: Text('Choose Wallet'),
              items: [
                DropdownMenuItem(
                  value: 'TouchNGo',
                  child: Row(
                    children: [
                      Image(image: TouchNGoLogo, height: 40, width: 80,),
                      SizedBox(width: 9,),
                      Text('TouchNGo')
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'GrabPay',
                  child: Row(
                    children: [
                      Image(image: GrabPayLogo, height: 40, width: 80,),
                      SizedBox(width: 9,),
                      Text('TouchNGo')
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'Boost',
                  child: Row(
                    children: [
                      Image(image: BoostLogo, height: 40, width: 80,),
                      SizedBox(width: 9,),
                      Text('TouchNGo')
                    ],
                  ),
                )
              ],
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
                  controller: _phone,
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
                  onPressed: () {}, 
                  child: Text('Cancel')
                ),
                SizedBox(width: 9,),
                ElevatedButton(
                  onPressed: () {}, 
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

  AddAccountDialogViewmodel({this.type});
}
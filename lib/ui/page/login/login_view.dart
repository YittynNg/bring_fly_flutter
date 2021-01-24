import '../../../util/validator.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import './signinform_viewmodel.dart';
import 'auth_view.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {

  final TextEditingController _email = TextEditingController()..text = 'example@gmail.com';
  final TextEditingController _password = TextEditingController();//..text = '000000';
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  // bool _obscureText;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    _emailEditingComplete() {
      FocusScope.of(context).requestFocus(_passwordFocusNode);
    }

    void _submit(SignInFormModel model) async {
      FocusScope.of(context).unfocus();
      await model.checkCanSignIn(_email.text, _password.text);
      // if (_formKey.currentState.validate()) {
      //   FocusScope.of(context).unfocus();
      //   await model.checkCanSignIn(_email.text, _password.text);
      //   // Navigator.pushNamed(context, RootPageRoute);
      // }
    }

    bool _obscureText = true;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).primaryColor,
          child: Column(
            children: [
              Container(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Universal Wallet', style: Theme.of(context).textTheme.headline3.copyWith(color: Colors.white),),
                    Text('All In One, One For All”', textAlign: TextAlign.center, style: TextStyle(color: Colors.white))
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)
                    ),
                  ),
                  child: ViewModelBuilder<SignInFormModel>.reactive(
                    viewModelBuilder: () => SignInFormModel(),
                    onModelReady: (model) {
                      print('LOGIN MODEL INIT');
                    },
                    builder: (context, model, _) {
                      return Column(
                        children: [
                          // SizedBox(height: 9,),
                          Form(
                            key: _formKey,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 9, vertical: 9
                              ),
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    enabled: model.isBusy ? false : true,
                                    controller: _email,
                                    focusNode: _emailFocusNode,
                                    style: TextStyle(color: Colors.black),
                                    textInputAction: TextInputAction.next,
                                    onEditingComplete: () =>
                                        _emailEditingComplete(),
                                    keyboardType: TextInputType.emailAddress,
                                    cursorColor: Colors.black,
                                    validator: Validator.emailValidator,
                                    autocorrect: false,
                                    decoration: InputDecoration(
                                      fillColor: Colors.grey[100],
                                      filled: true,
                                      labelText: "Email",
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
                                  SizedBox(
                                    height: 9,
                                  ),
                                  StatefulBuilder(
                                    builder: (context, setState) {
                                      return TextFormField(
                                        enabled: model.isBusy ? false : true,
                                        controller: _password,
                                        focusNode: _passwordFocusNode,
                                        style: TextStyle(color: Colors.black),
                                        onEditingComplete: () => _submit(model),
                                        textInputAction: TextInputAction.done,
                                        keyboardType: TextInputType.visiblePassword,
                                        cursorColor: Colors.black,
                                        validator: Validator.pwdValidator,
                                        obscureText: _obscureText,
                                        autocorrect: false,
                                        decoration: InputDecoration(
                                          fillColor: Colors.grey[100],
                                          filled: true,
                                          labelText: "Password",
                                          labelStyle: TextStyle(color: Colors.black,),
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _obscureText = !_obscureText;
                                              });
                                            },
                                            icon: Icon(Icons.remove_red_eye),
                                          ),
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
                                      );
                                    },
                                  ),

                                  SizedBox(height: 36,),

                                  model.isBusy
                                      ? Center(
                                          child: Container(
                                            height: 36,
                                            width: 36,
                                            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),),
                                          )
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25.0, vertical: 10),
                                          child: GestureDetector(
                                            onTap: () => _submit(model),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(14)),
                                              child: Container(
                                                height: 50,
                                                color: Colors.white,
                                                padding: const EdgeInsets.all(12.0),
                                                alignment: Alignment.bottomCenter,
                                                child: Center(
                                                  child: Text(
                                                    'Login',
                                                    style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.black)
                                                        .copyWith(
                                                            // color: Colors.white,
                                                            fontSize: 17),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                  InkWell(
                                    onTap: model.isBusy
                                    ? null
                                    : () {
                                        Provider.of<AuthViewController>(context, listen: false).goToForgotPassword();
                                      },
                                    child: Container(
                                      height: 16,
                                      child: Center(
                                        child: Text(
                                          "Forgot Password?",
                                          style: Theme.of(context).textTheme.overline.copyWith(color: Colors.black),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  InkWell(
                                    onTap: model.isBusy
                                    ? null
                                    : () {
                                        Provider.of<AuthViewController>(context, listen: false).goToSignUp();
                                      },
                                    child: Container(
                                      height: 30,
                                      // color: Colors.red,
                                      child: Center(
                                        child: Text(
                                          "Sign up now",
                                          style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.black),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    }
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../util/validator.dart';
import './verification_viewmodel.dart';

import 'package:stacked/stacked.dart';

class VerificationPage extends StatefulWidget {
  final String email;
  final String phone;
  // final SignUpModel signUpModel;
  // final FirebaseAuth auth;

  VerificationPage(
      {this.email, this.phone = '+601126575330'});

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  var onTapRecognizer;
  TextEditingController _textEditingController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String currentText = "";
  StreamController<ErrorAnimationType> errorController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String hasError;

  // Phone Verification
  bool _resendLocked = false;
  Timer _timer;
  int _timeleft = 60;
  String _verificationId;
  int _resendToken;

  @override
  initState() {
    _textEditingController = TextEditingController(text: "");
    errorController = StreamController<ErrorAnimationType>();
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        sendPhoneCode();
        // Navigator.pop(context, false);
      };
    super.initState();
    // if (widget.phone != null) {
    //   sendPhoneCode();
    // }
    sendPhoneCode();
  }

  void sendPhoneCode({bool forceResend = false}) {
    print("running send phone code in verification page");
    // print(widget.phone);
    // widget.auth.verifyPhoneNumber(
    //     phoneNumber: widget.phone,
    //     timeout: const Duration(seconds: 50),
    //     verificationCompleted: (PhoneAuthCredential credential) async {
    //       print('=== verificationCompleted ===');
    //       await widget.auth.signInWithCredential(credential).catchError((err) {
    //         print(err);
    //       });
    //       Navigator.pop(context, true);
    //     },
    //     verificationFailed: (FirebaseAuthException e) {
    //       print('=== verificationFailed : $e ===');
    //     },
    //     codeSent: (String verificationId, int resendToken) {
          startTimer();
    //       setState(() {
    //         _verificationId = verificationId;
    //         _resendToken = resendToken;
    //       });
    //       print("THIS IS THE VERIFICATION ID: $_verificationId");
    //       print('=== codeSent ===');
    //     },
    //     codeAutoRetrievalTimeout: (String verificationId) {
    //       print('=== codeAutoRetrievalTimeout ===');
    //       setState(() {
    //         _verificationId = verificationId;
    //       });
    //       print(
    //           "THIS IS THE VERIFICATION ID: $_verificationId from codeAutoRetrievalTimeout");
    //     },
    //     forceResendingToken: forceResend ? _resendToken : null);
  }

  void startTimer() {
    setState(() {
      _resendLocked = true;
    });
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_timeleft <= 1) {
            timer.cancel();
            setState(() {
              _resendLocked = false;
            });
          } else {
            setState(() {
              _timeleft = _timeleft - 1;
            });
          }
        },
      ),
    );
  }

  void _validate(BuildContext context, VerificationModel model, String code) async {
    bool invalidCode = false;
    // _formKey.currentState.validate();
    model.setBusy(true);

    String validated = Validator.pinValidator(code);
    if(validated != null) {
      model.setBusy(false);
      setState(() {
        hasError = validated;
      });
      return;
    }

    invalidCode = await model.verifyCode(code);

    // conditions for validating
    if (code.length != 6 || invalidCode) {
      errorController
          .add(ErrorAnimationType.shake); //Triggering error shake animation
      setState(() {
        hasError = "*Incorrect Pin";
      });
      // Navigator.pop(context, false);
    } else {
      setState(() {
        hasError = null;
      });
      model.setBusy(false);
      Navigator.pop(context, true);
    }
    model.setBusy(false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text('Verifiy'),
          ),
          body: ViewModelBuilder<VerificationModel>.reactive(
              viewModelBuilder: () => VerificationModel(),
              builder: (context, model, _) {
                return SingleChildScrollView(
                  child: Container(
                    // decoration: BoxDecoration(
                    //   color: Colors.white,
                    // ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 24),
                          child: Text(
                            'Verification',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(26),
                          child: RichText(
                            text: TextSpan(
                              text:
                                  'Please enter the verification code that we sent to ',
                              style: Theme.of(context).textTheme.bodyText1,
                              children: <TextSpan>[
                                TextSpan(
                                    text: widget.phone,
                                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                                        color: Colors.orange,
                                        fontSize: 17)),
                              ],
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 30),
                            child: PinCodeTextField(
                              // backgroundColor: Theme.of(context).backgroundColor,
                              appContext: context,
                              keyboardType: TextInputType.number,
                              length: 6,
                              obscureText: true,
                              animationType: AnimationType.fade,
                              // validator: Validator.pinValidator,
                              pinTheme: PinTheme(
                                selectedColor: Theme.of(context).primaryColor,
                                shape: PinCodeFieldShape.underline,
                                inactiveColor: Colors.grey.withOpacity(0.40),
                                activeColor: Colors.grey,
                                fieldHeight: 50,
                                fieldWidth: 40,
                                activeFillColor:
                                    hasError != null ? Colors.red : Colors.white,
                              ),
                              animationDuration: Duration(milliseconds: 300),
                              errorAnimationController: errorController,
                              controller: _textEditingController,
                              onCompleted: (v) {
                                _validate(context, model, _textEditingController.text);
                              },
                              onChanged: (value) {
                                print(value);
                                // setState(() {
                                //   currentText = value;
                                // });
                              },
                              beforeTextPaste: (text) {
                                print("Allowing to paste $text");
                                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                return true;
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Text(hasError != null ? hasError : "",
                              style: TextStyle(color: Colors.red)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: "Didn't receive the code? ",
                              style: Theme.of(context).textTheme.overline.copyWith(fontWeight: FontWeight.normal),
                              children: [
                                _resendLocked
                                    ? TextSpan(
                                        text: ' $_timeleft s',
                                      )
                                    : TextSpan(
                                        text: " RESEND",
                                        style: Theme.of(context).textTheme.overline.copyWith(color: Colors.blue),
                                        recognizer: onTapRecognizer,
                                      )
                              ]),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        model.isBusy
                            ? Center(child: CircularProgressIndicator())
                            : Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: GestureDetector(
                                  onTap: () => _validate(context, model, _textEditingController.text),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    child: Container(
                                      color: Colors.green,
                                      padding: const EdgeInsets.all(17.0),
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        'Verify',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FlatButton(
                              child: Text("Clear"),
                              onPressed: () {
                                _textEditingController.clear();
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    errorController.close();
    // _textEditingController.dispose();
    // _emailFocusNode.dispose();
    _timer.cancel();

    super.dispose();
  }
}
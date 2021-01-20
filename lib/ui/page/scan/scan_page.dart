import 'package:bringfly_uniwallet/ui/page/scan/qr_view.dart';
import 'package:bringfly_uniwallet/ui/page/scan/scan_viewmodel.dart';
import 'package:bringfly_uniwallet/ui/widget/account_card.dart';
import 'package:bringfly_uniwallet/util/validator.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanPage extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _amount = TextEditingController();//..text = '000000';
  final FocusNode _amountFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {

    _amountEditingComplete() async {
      if(_formKey.currentState.validate()) {
        FocusScope.of(context).unfocus();
      }
    }

    // QRViewController controller;
    final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

    return ViewModelBuilder<ScanViewModel>.reactive(
      viewModelBuilder: () => ScanViewModel(),
      builder: (context, model, _) {
        
        void _onQRViewCreated(QRViewController controller) {
          print('_onQRViewCreated 1');
          controller.scannedDataStream.listen((scanData) {
            model.recipient = true;
            model.notifyListeners();
          });
          print('_onQRViewCreated 2');
        }

        Widget _buildQrView(BuildContext context) {
          // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
          var scanArea = (MediaQuery.of(context).size.width < 400 ||
                  MediaQuery.of(context).size.height < 400)
              ? 150.0
              : 300.0;
          // To ensure the Scanner view is properly sizes after rotation
          // we need to listen for Flutter SizeChanged notification and update controller
          print('_buildQrView');
          return QRView(
            key: qrKey,
            cameraFacing: CameraFacing.front,
            onQRViewCreated: _onQRViewCreated,
            formatsAllowed: [BarcodeFormat.qrcode],
            overlay: QrScannerOverlayShape(
              borderColor: Colors.red,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: scanArea,
            ),
          );
        }

        _goToAmountPage() {
          model.selectedAccount = true;
          model.notifyListeners();
        }

        _scanRecipient() {
          model.selectedType = true;
          model.notifyListeners();
          // Navigator.of(context).push(MsaterialPageRoute(builder: (context) => MyQRView()));
        }

        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text('Scan'),
          ),
          body: model.selectedType == null
              ? Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(9),
                    child: Text('Choose your recipient'),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          AccountCard(_scanRecipient),
                          AccountCard(_scanRecipient),
                          AccountCard(_scanRecipient),
                          AccountCard(_scanRecipient)
                        ],
                      ),
                    ),
                  )
                ],
              )
              : model.recipient == null
                  ? _buildQrView(context) 
                  : model.selectedAccount == null
                      ? Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(9),
                            child: Text('Choose account to pay'),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  MyAccountCard(_goToAmountPage),
                                  MyAccountCard(_goToAmountPage),
                                  MyAccountCard(_goToAmountPage),
                                  MyAccountCard(_goToAmountPage)
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                      : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 9, right: 9, top: 9),
                              child: Text('To Recipient'),
                            ),
                            AccountCard(() {}),
                            Padding(
                              padding: const EdgeInsets.only(left: 9, right: 9, top: 9),
                              child: Text('From Account'),
                            ),
                            MyAccountCard(() {}),
                            SizedBox(height: 18),
                            // Padding(
                            //   padding: const EdgeInsets.all(9.0),
                            //   child: Text('Enter Amount'),
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: Form(
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
                                    labelText: "Enter Amount",
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
                            Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(primary: Colors.green),
                                    onPressed: () {}, 
                                    child: Text('Confirm')
                                  ),
                                ]
                              ),
                            )
                          ],
                        ),
                      ),
        );
      }
    );
  }
}
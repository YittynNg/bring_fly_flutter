import 'package:bringfly_uniwallet/ui/widget/transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AccountQRWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      type: MaterialType.card,
      child: Container(
        height: 300,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 9,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.keyboard_arrow_down),
                  Text('Scan Me', style: Theme.of(context).textTheme.headline6),
                  Icon(Icons.keyboard_arrow_down)
                ],
              ),
              Expanded(
                child: Center(
                  child: QrImage(
                    size: 180,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    dataModuleStyle: QrDataModuleStyle(dataModuleShape: QrDataModuleShape.circle),
                    eyeStyle: QrEyeStyle(eyeShape: QrEyeShape.circle, color: Colors.black),
                    data: '0002020102115204000053034585802MY5914CHEE WAI XIONG6002MY26520014A000000615000101065888300220PF201205105937311574622206046119070485980802026304A04C',
                  ),
                ),
              ),
              // TransactionWidget(),
              // TransactionWidget(),
              // TransactionWidget(),
              // TransactionWidget(),
              // TransactionWidget(),
              // TransactionWidget(),
              // TransactionWidget(),
              // TransactionWidget(),
              // SizedBox(height: 9,)
            ],
          ),
        ),
      ),
    );
  }
}
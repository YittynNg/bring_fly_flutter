import 'package:bringfly_uniwallet/ui/constant/logo.dart';
import 'package:bringfly_uniwallet/ui/page/account/account_page.dart';
import 'package:flutter/material.dart';

class TransactionWidget extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        // height: 60,
        padding: EdgeInsets.only(top: 9),
        // child: ListTile(
        //   title: Text('Title'),
        //   subtitle: Text('Time'),
        //   trailing: Text('-RM255.00'),
        // ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title', style: Theme.of(context).textTheme.subtitle1,),
                  Text('Time', style: Theme.of(context).textTheme.overline,),
                ],
              ),
            ),
            Text('-RM255.00')
          ],
        ),
      ),
    );
  }
}
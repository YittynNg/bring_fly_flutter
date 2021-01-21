

import 'package:flutter/material.dart';

import 'telco/telco_bill_page_view.dart';

class BillPageView extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Bill'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: BillCard('assets/bill/tv.png', 'TV & Radio', (){}),
                ),
                Expanded(
                  child: BillCard('assets/bill/broadband.png', 'Broadband, Voice\n& Psotpaid Service', (){}),
                )
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: BillCard('assets/bill/water.png', 'Water', (){}),
                ),
                Expanded(
                  child: BillCard('assets/bill/electricity.png', 'Electricity', (){}),
                )
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: BillCard('assets/bill/telco.png', 'Prepaid Telco', (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return TelcoBillPageView();
                    }));
                  }),
                ),
                Expanded(
                  child: BillCard('assets/bill/other.png', 'Other', (){}),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BillCard extends StatelessWidget {

  final String asset;
  final String name;
  final Function _onTap;

  BillCard(this.asset, this.name, this._onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: InkWell(
        onTap: _onTap,
        child: Card(
          elevation: 3,
          child: Container(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(asset, height: 90, width: 90,),
                SizedBox(height: 9,),
                Text(name, textAlign: TextAlign.center,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
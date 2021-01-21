import '../../locator.dart';
import '../../service/auth_service.dart';
import '../page/bill/bill_page_view.dart';
import '../page/receive/receive_with_qr.dart';
import '../page/scan/scan_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).primaryColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 128,
                color: Theme.of(context).accentColor,
              ),
              // ListTile(
              //   leading: Icon(Icons.home, color: Colors.white),
              //   title: Text('Home', style: TextStyle(color: Colors.white),),
              //   onTap: () {},
              // ),
              ListTile(
                leading: Icon(Icons.qr_code, color: Colors.white),
                title: Text('Scan QR', style: TextStyle(color: Colors.white),),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ScanPage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.payments, color: Colors.white),
                title: Text('Pay', style: TextStyle(color: Colors.white),),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.attach_money, color: Colors.white),
                title: Text('Receive', style: TextStyle(color: Colors.white),),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ReceiveWithQRPageView()));
                },
              ),
              ListTile(
                leading: Icon(Icons.file_copy, color: Colors.white),
                title: Text('Bills', style: TextStyle(color: Colors.white),),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => BillPageView()));
                },
              ),
              ListTile(
                leading: Icon(Icons.history, color: Colors.white),
                title: Text('Transaction History', style: TextStyle(color: Colors.white),),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.list, color: Colors.white),
                title: Text('Promotion List', style: TextStyle(color: Colors.white),),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.notifications, color: Colors.white),
                title: Text('Notifications', style: TextStyle(color: Colors.white),),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.white),
                title: Text('Settings', style: TextStyle(color: Colors.white),),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.white),
                title: Text('Logout', style: TextStyle(color: Colors.white),),
                onTap: () {
                  locator<AuthService>().signOut();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
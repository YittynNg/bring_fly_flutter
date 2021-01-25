import './ui/page/home/home_view.dart';
import './ui/page/login/auth_view.dart';
import 'package:flutter/material.dart';
import './ui/common/theme.dart';
// import './ui/page/home.dart';
import './ui/page/login/login_view.dart';
import './ui/utils/LoadingPage.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';
import './service/auth_service.dart';
import './locator.dart';
import './logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('0');
  setupLocator();
  runApp(MyMain());
}

class MyMain extends StatelessWidget {
  final hive = Hive.box('0');

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(
          create: (_) => locator<AuthService>()..init(),
        ),
      ],
      child: ValueListenableBuilder(
        valueListenable: hive.listenable(keys: ['isDark']),
        builder: (context, box, _) => MaterialApp(
          title: '5N',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          // themeMode: box.get('isDark', defaultValue: false) ? ThemeMode.dark : ThemeMode.light,

          navigatorKey: locator<NavigationService>().navigatorKey,
          home: Root(),
        ),
      ),
    );
  }
}

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('<ROOT>');
    // return RootAuth(
    //   authenticated: () => Home(''), 
    //   unauthenticated: () => LoginPage()
    // );
    return Consumer<AuthService>(
      builder: (BuildContext context, AuthService authService, __) {
        print('ROOT ${authService.status}');
        switch (authService.status) {
          case AuthStatus.Uninitialized:
            return LoadingPage(message: 'Welcome to Uniwallet\nAll in 1, 1 for All',);
          case AuthStatus.Unauthenticated:
            return ChangeNotifierProvider<AuthViewController>(
              create: (_) => AuthViewController(),
              child: AuthView(),
              lazy: false,
            );
            // return ForgotPasswordView();
            // return SignUpView();
          case AuthStatus.Authenticated:
            return Home();
          default:
            return SizedBox();
        }
      },
    );
  }
}
import 'package:firebase_core/firebase_core.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:novel_log/models/router_models/drawer_state_provider.dart';
import 'package:novel_log/models/router_models/page_state_provider.dart';
import 'package:novel_log/router/my_app_router_delegate.dart';
import 'package:novel_log/router/my_app_router_information_parser.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/utility/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

late SharedPreferences prefs;
FlashController? flashController;
PageStateProvider pageStateProvider = PageStateProvider();
DrawerStateProvider drawerStateProvider = DrawerStateProvider();
GlobalKey<NavigatorState> navigateKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final MyAppRouterDelegate delegate = MyAppRouterDelegate();
  final parser = MyAppRouterInformationParser();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: MaterialApp.router(
        title: appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: appThemeColor,
          primaryColor: appPrimaryColor,
        ),
        routerDelegate: delegate,
        routeInformationParser: parser,
      ),
    );
  }

//end of file
}

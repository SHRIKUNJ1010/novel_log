import 'package:firebase_core/firebase_core.dart';
import 'package:flash/flash.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel_log/router/my_app_router_delegate.dart';
import 'package:novel_log/router/my_app_router_information_parser.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/utility/constants.dart';
import 'package:novel_log/utility/firebase_services/firebase_options.dart';
import 'package:novel_log/utility/local_database_services/local_database_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/router_models/router_state_provider/drawer_state_provider.dart';
import 'models/router_models/router_state_provider/page_state_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  if (!kIsWeb) {
    await localDb.initDatabase();
  }
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

late SharedPreferences prefs;
final LocalDatabaseServices localDb = LocalDatabaseServices();
FlashController? flashController;
PageStateProvider pageStateProvider = PageStateProvider();
DrawerStateProvider drawerStateProvider = DrawerStateProvider();
GlobalKey<NavigatorState> navigateKey = GlobalKey<NavigatorState>();
GlobalKey<NavigatorState> drawerNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MyAppRouterDelegate delegate = MyAppRouterDelegate();
  final MyAppRouterInformationParser parser = MyAppRouterInformationParser();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: appThemeColor,
        primaryColor: appPrimaryColor,
      ),
      routerDelegate: delegate,
      routeInformationParser: parser,
    );
  }
}

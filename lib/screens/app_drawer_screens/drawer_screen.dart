/*
* Created by Shrikunj Patel on 1/23/2023.
*/
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:novel_log/main.dart';
import 'package:novel_log/screens/app_drawer_screens/change_hidden_pin_screen.dart';
import 'package:novel_log/screens/app_drawer_screens/change_password_screen.dart';
import 'package:novel_log/screens/app_drawer_screens/novel_hidden_list_screen.dart';
import 'package:novel_log/screens/app_drawer_screens/novel_wish_list_screen.dart';
import 'package:novel_log/screens/app_drawer_screens/profile_screen.dart';
import 'package:novel_log/screens/app_drawer_screens/your_novel_list_screen.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/utility/page_config_list.dart';
import 'package:novel_log/utility/page_routes.dart';
import 'package:novel_log/utility/utility.dart';
import 'package:novel_log/widgets/common_widgets/text_widget.dart';
import 'package:novel_log/widgets/drawer_screen_widgets/drawer_item_button.dart';
import 'package:novel_log/widgets/drawer_screen_widgets/drawer_selected_item_button.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  String selectedPath = yourNovelListScreenRoute;
  StreamController<String> selectedTabController = StreamController<String>.broadcast();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<NavigatorState> drawerNavigatorKey = GlobalKey<NavigatorState>();

  String getAppBarTitle(String selectedValue) {
    switch (selectedValue) {
      case yourNovelListScreenRoute:
        return 'Your Novels';
      case novelWishListScreenRoute:
        return 'Wish List';
      case novelHiddenListScreenRoute:
        return 'Hidden List';
      case profileScreenRoute:
        return 'Profile';
      case changePasswordScreenRoute:
        return 'Change Password';
      case changeHiddenPinScreenRoute:
        return 'Change Pin';
      default:
        return 'Drawer Screen';
    }
  }

  List<String> drawerItemTitleText = [
    'Your Novels',
    'Wish List',
    'Hidden List',
    'Profile',
    'Change Password',
    'Change Pin',
    'Logout',
  ];

  List<String> drawerItemPathList = [
    yourNovelListScreenRoute,
    novelWishListScreenRoute,
    novelHiddenListScreenRoute,
    profileScreenRoute,
    changePasswordScreenRoute,
    changeHiddenPinScreenRoute,
    'logout',
  ];

  List<IconData> drawerItemIcon = [
    Icons.home_outlined,
    Icons.home_outlined,
    Icons.home_outlined,
    Icons.home_outlined,
    Icons.home_outlined,
    Icons.home_outlined,
    Icons.home_outlined,
  ];

  List<IconData> selectedDrawerItemIcon = [
    Icons.home,
    Icons.home,
    Icons.home,
    Icons.home,
    Icons.home,
    Icons.home,
    Icons.home,
  ];

  onDrawerItemTap(BuildContext context, int index) {
    switch (drawerItemTitleText[index]) {
      case 'Your Novels':
        drawerStateProvider.changeCurrentSelectedPage(PageConfigList.getYourNovelListScreen());
        break;
      case 'Wish List':
        drawerStateProvider.changeCurrentSelectedPage(PageConfigList.getNovelWishListScreen());
        break;
      case 'Hidden List':
        drawerStateProvider.changeCurrentSelectedPage(PageConfigList.getNovelHiddenListScreen());
        break;
      case 'Profile':
        drawerStateProvider.changeCurrentSelectedPage(PageConfigList.getProfileScreen());
        break;
      case 'Change Password':
        drawerStateProvider.changeCurrentSelectedPage(PageConfigList.getChangePasswordScreen());
        break;
      case 'Change Pin':
        drawerStateProvider.changeCurrentSelectedPage(PageConfigList.getChangeHiddenPinScreen());
        break;
      case 'Logout':
        //do logout
        break;
    }
    Navigator.of(context).pop();
  }

  onHorizontalDrawerItemTap(BuildContext context, int index) {
    switch (drawerItemTitleText[index]) {
      case 'Your Novels':
        drawerStateProvider.changeCurrentSelectedPage(PageConfigList.getYourNovelListScreen());
        break;
      case 'Wish List':
        drawerStateProvider.changeCurrentSelectedPage(PageConfigList.getNovelWishListScreen());
        break;
      case 'Hidden List':
        drawerStateProvider.changeCurrentSelectedPage(PageConfigList.getNovelHiddenListScreen());
        break;
      case 'Profile':
        drawerStateProvider.changeCurrentSelectedPage(PageConfigList.getProfileScreen());
        break;
      case 'Change Password':
        drawerStateProvider.changeCurrentSelectedPage(PageConfigList.getChangePasswordScreen());
        break;
      case 'Change Pin':
        drawerStateProvider.changeCurrentSelectedPage(PageConfigList.getChangeHiddenPinScreen());
        break;
      case 'Logout':
        //do logout
        break;
    }
  }

  @override
  void initState() {
    selectedTabController.add(drawerStateProvider.selectedPageConfig.path);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      drawerStateProvider.addListener(() {
        selectedTabController.add(drawerStateProvider.selectedPageConfig.path);
      });
      selectedTabController.stream.listen((event) {
        selectedPath = event;
        Navigator.pushReplacementNamed(drawerNavigatorKey.currentContext!, event);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    selectedTabController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    if (width > 800) {
      return Row(
        children: [
          StreamBuilder<String>(
              stream: selectedTabController.stream,
              builder: (context, snapshot) {
                return Drawer(
                  backgroundColor: appPrimaryColor,
                  child: SizedBox(
                    width: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 170 + MediaQuery.of(context).padding.top,
                              color: appThemeColor[100],
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: drawerItemTitleText.length,
                            itemBuilder: (context, index) {
                              if ((snapshot.data ?? yourNovelListScreenRoute) == drawerItemPathList[index]) {
                                return DrawerSelectedItemButton(
                                  icon: Utility.getSelectedDrawerItemIcon(icon: selectedDrawerItemIcon[index]),
                                  onTap: () {
                                    onHorizontalDrawerItemTap(context, index);
                                  },
                                  title: drawerItemTitleText[index],
                                );
                              } else {
                                return DrawerItemButton(
                                  icon: Utility.getDefaultDrawerItemIcon(icon: drawerItemIcon[index]),
                                  onTap: () {
                                    onHorizontalDrawerItemTap(context, index);
                                  },
                                  title: drawerItemTitleText[index],
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
          Expanded(
            child: StreamBuilder<String>(
                stream: selectedTabController.stream,
                builder: (context, snapshot) {
                  return Navigator(
                    key: drawerNavigatorKey,
                    initialRoute: snapshot.data ?? yourNovelListScreenRoute,
                    onGenerateRoute: (RouteSettings settings) {
                      RoutePageBuilder builder;
                      switch (settings.name) {
                        case yourNovelListScreenRoute:
                          builder = (_, __, ___) => const YourNovelListScreen(showAppBar: true);
                          break;
                        case novelWishListScreenRoute:
                          builder = (_, __, ___) => const NovelWishListScreen(showAppBar: true);
                          break;
                        case novelHiddenListScreenRoute:
                          builder = (_, __, ___) => const NovelHiddenListScreen(showAppBar: true);
                          break;
                        case profileScreenRoute:
                          builder = (_, __, ___) => const ProfileScreen(showAppBar: true);
                          break;
                        case changePasswordScreenRoute:
                          builder = (_, __, ___) => const ChangePasswordScreen(showAppBar: true);
                          break;
                        case changeHiddenPinScreenRoute:
                          builder = (_, __, ___) => const ChangeHiddenPinScreen(showAppBar: true);
                          break;
                        default:
                          builder = (_, __, ___) => const YourNovelListScreen(showAppBar: true);
                          break;
                      }
                      return PageRouteBuilder(
                        pageBuilder: builder,
                        transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                        maintainState: true,
                      );
                    },
                  );
                }),
          ),
        ],
      );
    } else {
      return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              scaffoldKey.currentState!.openDrawer();
            },
            child: const Icon(
              Icons.menu,
              color: mWhite,
              size: 30,
            ),
          ),
          centerTitle: true,
          title: StreamBuilder<String>(
              stream: selectedTabController.stream,
              builder: (context, snapshot) {
                return TextView(label: getAppBarTitle(snapshot.data ?? yourNovelListScreenRoute));
              }),
        ),
        drawer: Drawer(
          backgroundColor: appPrimaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 170 + MediaQuery.of(context).padding.top,
                    color: appThemeColor[100],
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, top: 15),
                      child: InkWell(
                        onTap: () {
                          scaffoldKey.currentState!.closeDrawer();
                        },
                        child: const Icon(
                          Icons.menu,
                          color: mWhite,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: drawerItemTitleText.length,
                  itemBuilder: (context, index) {
                    if (selectedPath == drawerItemPathList[index]) {
                      return DrawerSelectedItemButton(
                        icon: Utility.getSelectedDrawerItemIcon(icon: selectedDrawerItemIcon[index]),
                        onTap: () {
                          onDrawerItemTap(context, index);
                        },
                        title: drawerItemTitleText[index],
                      );
                    } else {
                      return DrawerItemButton(
                        icon: Utility.getDefaultDrawerItemIcon(icon: drawerItemIcon[index]),
                        onTap: () {
                          onDrawerItemTap(context, index);
                        },
                        title: drawerItemTitleText[index],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        body: StreamBuilder<String>(
            stream: selectedTabController.stream,
            builder: (context, snapshot) {
              return Navigator(
                key: drawerNavigatorKey,
                initialRoute: snapshot.data ?? yourNovelListScreenRoute,
                onGenerateRoute: (RouteSettings settings) {
                  RoutePageBuilder builder;
                  switch (settings.name) {
                    case yourNovelListScreenRoute:
                      builder = (_, __, ___) => const YourNovelListScreen(showAppBar: false);
                      break;
                    case novelWishListScreenRoute:
                      builder = (_, __, ___) => const NovelWishListScreen(showAppBar: false);
                      break;
                    case novelHiddenListScreenRoute:
                      builder = (_, __, ___) => const NovelHiddenListScreen(showAppBar: false);
                      break;
                    case profileScreenRoute:
                      builder = (_, __, ___) => const ProfileScreen(showAppBar: false);
                      break;
                    case changePasswordScreenRoute:
                      builder = (_, __, ___) => const ChangePasswordScreen(showAppBar: false);
                      break;
                    case changeHiddenPinScreenRoute:
                      builder = (_, __, ___) => const ChangeHiddenPinScreen(showAppBar: false);
                      break;
                    default:
                      builder = (_, __, ___) => const YourNovelListScreen(showAppBar: false);
                      break;
                  }
                  return PageRouteBuilder(
                    pageBuilder: builder,
                    transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                    maintainState: true,
                  );
                },
              );
            }),
      );
    }
  }
}

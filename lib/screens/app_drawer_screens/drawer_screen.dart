/*
* Created by Shrikunj Patel on 1/23/2023.
*/
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:novel_log/main.dart';
import 'package:novel_log/models/getx_controller_model/drawer_selected_tab_controller.dart';
import 'package:novel_log/models/getx_controller_model/hidden_pin_controller.dart';
import 'package:novel_log/models/getx_controller_model/your_novel_list_controller.dart';
import 'package:novel_log/router/drawer_router_delegate.dart';
import 'package:novel_log/utility/assets_path.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/utility/enum_variable_types.dart';
import 'package:novel_log/utility/firebase_services/firebase_auth_service.dart';
import 'package:novel_log/utility/page_and_transition_services/page_config_list.dart';
import 'package:novel_log/utility/page_and_transition_services/page_routes.dart';
import 'package:novel_log/utility/preference.dart';
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
  late final DrawerRouterDelegate delegate;
  DrawerSelectedTabController selectedTabController = Get.put(DrawerSelectedTabController());
  HiddenPinController pinController = Get.put(HiddenPinController());
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> drawerItemTitleText = [
    'Your Novels',
    'Wish List',
    'Hidden List',
    //'Enter Pin',
    'Profile',
    'Change Password',
    'Change Pin',
    'Logout',
  ];

  List<String> drawerItemPathList = [
    yourNovelListScreenRoute,
    novelWishListScreenRoute,
    //novelHiddenListScreenRoute,
    enterPinScreenRoute,
    profileScreenRoute,
    changePasswordScreenRoute,
    changeHiddenPinScreenRoute,
    'logout',
  ];

  List<IconData> drawerItemIcon = [
    FontAwesome5.book,
    FontAwesome.heart_empty,
    Icons.security_outlined,
    FontAwesome.user,
    FontAwesome.keyboard,
    FontAwesome5.key,
    FontAwesome.logout,
  ];

  List<double> iconSizeList = [
    28,
    30,
    35,
    35,
    29,
    31,
    33,
  ];

  List<IconData> selectedDrawerItemIcon = [
    FontAwesome5.book_open,
    FontAwesome.heart,
    Icons.security,
    FontAwesome.user,
    FontAwesome5.keyboard,
    FontAwesome5.key,
    FontAwesome.logout,
  ];

  List<double> selectedIconSizeList = [
    27,
    30,
    37,
    35,
    29,
    31,
    33,
  ];

  String getAppBarTitle(String selectedValue) {
    switch (selectedValue) {
      case yourNovelListScreenRoute:
        return 'Your Novels';
      case novelWishListScreenRoute:
        return 'Wish List';
      case novelHiddenListScreenRoute:
        return 'Hidden List';
      case enterPinScreenRoute:
        return ' Enter Pin';
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

  Future<void> changeDrawerItem(int index) async {
    switch (drawerItemPathList[index]) {
      case yourNovelListScreenRoute:
        drawerStateProvider.pushReplacement(PageConfigList.getYourNovelListScreen(Preference.getUserId()), TransitionType.foldTransition);
        break;
      case novelWishListScreenRoute:
        drawerStateProvider.pushReplacement(PageConfigList.getNovelWishListScreen(Preference.getUserId()), TransitionType.foldTransition);
        break;
      case enterPinScreenRoute:
        if (pinController.hasEnteredPassword) {
          drawerStateProvider.pushReplacement(PageConfigList.getNovelHiddenListScreen(Preference.getUserId()), TransitionType.foldTransition);
        } else {
          drawerStateProvider.pushReplacement(PageConfigList.getEnterPinScreen(Preference.getUserId()), TransitionType.foldTransition);
        }
        break;
      /*case 'Hidden List':
        drawerStateProvider.pushReplacement(PageConfigList.getNovelHiddenListScreen(Preference.getUserId()), TransitionType.foldTransition);
        break;*/
      case profileScreenRoute:
        drawerStateProvider.pushReplacement(PageConfigList.getProfileScreen(Preference.getUserId()), TransitionType.foldTransition);
        break;
      case changePasswordScreenRoute:
        drawerStateProvider.pushReplacement(PageConfigList.getChangePasswordScreen(Preference.getUserId()), TransitionType.foldTransition);
        break;
      case changeHiddenPinScreenRoute:
        drawerStateProvider.pushReplacement(PageConfigList.getChangeHiddenPinScreen(Preference.getUserId()), TransitionType.foldTransition);
        break;
      case 'logout':
        bool value = await Utility.userLogoutAlert();
        if (value) {
          doUserLogout();
        }
        return;
    }
  }

  onDrawerItemTap(BuildContext context, int index) async {
    await changeDrawerItem(index);
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  onHorizontalDrawerItemTap(BuildContext context, int index) async {
    changeDrawerItem(index);
  }

  doUserLogout() {
    FirebaseAuthService.signOut();
    pageStateProvider.pushReplacement(PageConfigList.getLoginScreen());
    Get.find<YourNovelListController>().clearList();
    //Get.find<NovelWishListController>().clearList();
    //Get.find<NovelHiddenListController>().clearList();
    Preference.setIsUserLoggedIn(false);
  }

  @override
  void initState() {
    delegate = DrawerRouterDelegate();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        selectedTabController.updateSelectedPath(drawerStateProvider.config[0].path);
        drawerStateProvider.addListener(
          () {
            selectedTabController.updateSelectedPath(drawerStateProvider.config[0].path);
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    //final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldKey,
      restorationId: 'drawer_scaffold',
      appBar: kIsWeb
          ? width < 701
              ? getAppBarWithDrawerIcon()
              : null
          : width < 901
              ? getAppBarWithDrawerIcon()
              : null,
      drawer: kIsWeb
          ? width < 701
              ? getCollapsableDrawer()
              : null
          : width < 901
              ? getCollapsableDrawer()
              : null,
      body: Row(
        children: [
          kIsWeb
              ? width > 700
                  ? getNonCollapsableDrawer()
                  : const SizedBox()
              : width > 900
                  ? getNonCollapsableDrawer()
                  : const SizedBox(),
          Expanded(
            child: getRouterView(),
          ),
        ],
      ),
    );
  }

  AppBar getAppBarWithDrawerIcon() {
    return AppBar(
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
      title: GetBuilder<DrawerSelectedTabController>(
        builder: (controller) {
          return TextView(label: getAppBarTitle(controller.selectedPath));
        },
      ),
    );
  }

  Widget getRouterView() {
    return GetBuilder<DrawerSelectedTabController>(
      builder: (controller) {
        return Router(
          routerDelegate: delegate,
        );
      },
    );
  }

  Widget getCollapsableDrawer() {
    return Drawer(
      backgroundColor: appPrimaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 170 + MediaQuery.of(context).padding.top,
                decoration: const BoxDecoration(
                  color: appPrimaryColor,
                  image: DecorationImage(
                    image: AssetImage(drawerLibraryBackground),
                    fit: BoxFit.cover,
                    opacity: 0.6,
                  ),
                ),
              ),
              SafeArea(
                child: InkWell(
                  onTap: () {
                    scaffoldKey.currentState!.closeDrawer();
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 15, top: 10),
                    child: Icon(
                      Icons.menu,
                      color: mWhite,
                      size: 30,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 5 + MediaQuery.of(context).padding.top,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      nlIconImage,
                      width: 70,
                      height: 70,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 75 + MediaQuery.of(context).padding.top,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    TextView(
                      label: 'Welcome',
                      color: mWhite,
                      fontSize: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          GetBuilder<DrawerSelectedTabController>(
            builder: (controller) {
              return Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: drawerItemTitleText.length,
                  itemBuilder: (context, index) {
                    if (drawerItemPathList[index] == enterPinScreenRoute) {
                      if (controller.selectedPath == enterPinScreenRoute || controller.selectedPath == novelHiddenListScreenRoute) {
                        return DrawerSelectedItemButton(
                          icon: Utility.getSelectedDrawerItemIcon(
                            icon: selectedDrawerItemIcon[index],
                            iconSize: selectedIconSizeList[index],
                          ),
                          onTap: () {
                            onDrawerItemTap(context, index);
                          },
                          title: drawerItemTitleText[index],
                        );
                      } else {
                        return DrawerItemButton(
                          icon: Utility.getDefaultDrawerItemIcon(
                            icon: drawerItemIcon[index],
                            iconSize: iconSizeList[index],
                          ),
                          onTap: () {
                            onDrawerItemTap(context, index);
                          },
                          title: drawerItemTitleText[index],
                        );
                      }
                    } else {
                      if (controller.selectedPath == drawerItemPathList[index]) {
                        return DrawerSelectedItemButton(
                          icon: Utility.getSelectedDrawerItemIcon(
                            icon: selectedDrawerItemIcon[index],
                            iconSize: selectedIconSizeList[index],
                          ),
                          onTap: () {
                            onDrawerItemTap(context, index);
                          },
                          title: drawerItemTitleText[index],
                        );
                      } else {
                        return DrawerItemButton(
                          icon: Utility.getDefaultDrawerItemIcon(
                            icon: drawerItemIcon[index],
                            iconSize: iconSizeList[index],
                          ),
                          onTap: () {
                            onDrawerItemTap(context, index);
                          },
                          title: drawerItemTitleText[index],
                        );
                      }
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget getNonCollapsableDrawer() {
    return GetBuilder<DrawerSelectedTabController>(
      builder: (controller) {
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
                      decoration: const BoxDecoration(
                        color: appPrimaryColor,
                        image: DecorationImage(
                          image: AssetImage(drawerLibraryBackground),
                          fit: BoxFit.cover,
                          opacity: 0.6,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 5 + MediaQuery.of(context).padding.top,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            nlIconImage,
                            width: 70,
                            height: 70,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 75 + MediaQuery.of(context).padding.top,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          TextView(
                            label: 'Welcome',
                            color: mWhite,
                            fontSize: 20,
                          ),
                        ],
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
                      if (drawerItemPathList[index] == enterPinScreenRoute) {
                        if (controller.selectedPath == enterPinScreenRoute || controller.selectedPath == novelHiddenListScreenRoute) {
                          return DrawerSelectedItemButton(
                            icon: Utility.getSelectedDrawerItemIcon(
                              icon: selectedDrawerItemIcon[index],
                              iconSize: selectedIconSizeList[index],
                            ),
                            onTap: () {
                              onHorizontalDrawerItemTap(context, index);
                            },
                            title: drawerItemTitleText[index],
                          );
                        } else {
                          return DrawerItemButton(
                            icon: Utility.getDefaultDrawerItemIcon(
                              icon: drawerItemIcon[index],
                              iconSize: iconSizeList[index],
                            ),
                            onTap: () {
                              onHorizontalDrawerItemTap(context, index);
                            },
                            title: drawerItemTitleText[index],
                          );
                        }
                      } else {
                        if (controller.selectedPath == drawerItemPathList[index]) {
                          return DrawerSelectedItemButton(
                            icon: Utility.getSelectedDrawerItemIcon(
                              icon: selectedDrawerItemIcon[index],
                              iconSize: selectedIconSizeList[index],
                            ),
                            onTap: () {
                              onHorizontalDrawerItemTap(context, index);
                            },
                            title: drawerItemTitleText[index],
                          );
                        } else {
                          return DrawerItemButton(
                            icon: Utility.getDefaultDrawerItemIcon(
                              icon: drawerItemIcon[index],
                              iconSize: iconSizeList[index],
                            ),
                            onTap: () {
                              onHorizontalDrawerItemTap(context, index);
                            },
                            title: drawerItemTitleText[index],
                          );
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

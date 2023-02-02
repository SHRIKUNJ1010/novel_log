/*
* Created by Shrikunj Patel on 1/23/2023.
*/
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:novel_log/main.dart';
import 'package:novel_log/models/getx_controller_model/drawer_selected_tab_controller.dart';
import 'package:novel_log/router/drawer_router_delegate.dart';
import 'package:novel_log/utility/assets_path.dart';
import 'package:novel_log/utility/color.dart';
import 'package:novel_log/utility/page_config_list.dart';
import 'package:novel_log/utility/page_routes.dart';
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
  final scaffoldKey = GlobalKey<ScaffoldState>();

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

  changeDrawerItem(int index) {
    switch (drawerItemTitleText[index]) {
      case 'Your Novels':
        drawerStateProvider.changeCurrentSelectedPage(PageConfigList.getYourNovelListScreen(Preference.getUserId()));
        break;
      case 'Wish List':
        drawerStateProvider.changeCurrentSelectedPage(PageConfigList.getNovelWishListScreen(Preference.getUserId()));
        break;
      case 'Hidden List':
        drawerStateProvider.changeCurrentSelectedPage(PageConfigList.getNovelHiddenListScreen(Preference.getUserId()));
        break;
      case 'Profile':
        drawerStateProvider.changeCurrentSelectedPage(PageConfigList.getProfileScreen(Preference.getUserId()));
        break;
      case 'Change Password':
        drawerStateProvider.changeCurrentSelectedPage(PageConfigList.getChangePasswordScreen(Preference.getUserId()));
        break;
      case 'Change Pin':
        drawerStateProvider.changeCurrentSelectedPage(PageConfigList.getChangeHiddenPinScreen(Preference.getUserId()));
        break;
      case 'Logout':
        //do logout
        break;
    }
  }

  onDrawerItemTap(BuildContext context, int index) {
    changeDrawerItem(index);
    Navigator.of(context).pop();
  }

  onHorizontalDrawerItemTap(BuildContext context, int index) {
    changeDrawerItem(index);
  }

  @override
  void initState() {
    delegate = DrawerRouterDelegate();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        selectedTabController.updateSelectedPath(drawerStateProvider.selectedPageConfig.path);
        drawerStateProvider.addListener(
          () {
            selectedTabController.updateSelectedPath(drawerStateProvider.selectedPageConfig.path);
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
      appBar: width < 600
          ? AppBar(
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
            )
          : null,
      drawer: width < 600
          ? Drawer(
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
                  GetBuilder<DrawerSelectedTabController>(builder: (controller) {
                    return Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: drawerItemTitleText.length,
                        itemBuilder: (context, index) {
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
                        },
                      ),
                    );
                  }),
                ],
              ),
            )
          : null,
      body: Row(
        children: [
          width > 600
              ? GetBuilder<DrawerSelectedTabController>(
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
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : const SizedBox(),
          Expanded(
            child: GetBuilder<DrawerSelectedTabController>(
              builder: (controller) {
                return Router(
                  routerDelegate: delegate,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/*
* Created by Shrikunj Patel on 1/24/2023.
*/

/*if (oldNovelData!.novelReadingStatus != novelReadingStatus) {
          final tempUserController = Get.put(UserDataController());
          switch (oldNovelData!.novelReadingStatus) {
            case NovelReadingStatus.notStarted:
              //do nothing
              break;
            case NovelReadingStatus.reading:
              //do nothing
              break;
            case NovelReadingStatus.hiatusCompleted:
              UserServices.changeHiatusNovelCountOfUser(
                widget.userId ?? Preference.getUserId(),
                tempUserController.userData.totalNovelReadCompleteWithNovelHiatus! - 1,
              );
              break;
            case NovelReadingStatus.completed:
              UserServices.changeCompleteNovelCountOfUser(
                widget.userId ?? Preference.getUserId(),
                tempUserController.userData.totalNovelReadCompleteWithNovelComplete! - 1,
              );
              break;
            default:
              break;
          }
          switch (novelReadingStatus) {
            case NovelReadingStatus.notStarted:
              //do nothing
              break;
            case NovelReadingStatus.reading:
              //do nothing
              break;
            case NovelReadingStatus.hiatusCompleted:
              UserServices.changeHiatusNovelCountOfUser(
                widget.userId ?? Preference.getUserId(),
                tempUserController.userData.totalNovelReadCompleteWithNovelHiatus! + 1,
              );
              break;
            case NovelReadingStatus.completed:
              UserServices.changeCompleteNovelCountOfUser(
                widget.userId ?? Preference.getUserId(),
                tempUserController.userData.totalNovelReadCompleteWithNovelComplete! + 1,
              );
              break;
            default:
              break;
          }
        }*/

/*if (oldNovelData!.novelReadingStatus != novelReadingStatus) {
          final tempUserController = Get.put(UserDataController());
          switch (oldNovelData!.novelReadingStatus) {
            case NovelReadingStatus.notStarted:
              //do nothing
              break;
            case NovelReadingStatus.reading:
              //do nothing
              break;
            case NovelReadingStatus.hiatusCompleted:
              UserServices.changeHiatusNovelCountOfUser(
                widget.userId ?? Preference.getUserId(),
                tempUserController.userData.totalNovelReadCompleteWithNovelHiatus! - 1,
              );
              break;
            case NovelReadingStatus.completed:
              UserServices.changeCompleteNovelCountOfUser(
                widget.userId ?? Preference.getUserId(),
                tempUserController.userData.totalNovelReadCompleteWithNovelComplete! - 1,
              );
              break;
            default:
              break;
          }
          switch (novelReadingStatus) {
            case NovelReadingStatus.notStarted:
              //do nothing
              break;
            case NovelReadingStatus.reading:
              //do nothing
              break;
            case NovelReadingStatus.hiatusCompleted:
              UserServices.changeHiatusNovelCountOfUser(
                widget.userId ?? Preference.getUserId(),
                tempUserController.userData.totalNovelReadCompleteWithNovelHiatus! + 1,
              );
              break;
            case NovelReadingStatus.completed:
              UserServices.changeCompleteNovelCountOfUser(
                widget.userId ?? Preference.getUserId(),
                tempUserController.userData.totalNovelReadCompleteWithNovelComplete! + 1,
              );
              break;
            default:
              break;
          }
        }
        if (oldNovelData!.readNovelChapterCount != int.parse(readChapterController.text)) {
          final tempUserController = Get.put(UserDataController());
          UserServices.changeTotalChapterReadCountOfUser(
            widget.userId ?? Preference.getUserId(),
            tempUserController.userData.totalChapterReadCount! + (int.parse(readChapterController.text) - (oldNovelData!.readNovelChapterCount ?? 0)),
          );
        }*/

/*if (oldNovelData!.novelReadingStatus != novelReadingStatus) {
          final tempUserController = Get.put(UserDataController());
          switch (oldNovelData!.novelReadingStatus) {
            case NovelReadingStatus.notStarted:
              //do nothing
              break;
            case NovelReadingStatus.reading:
              //do nothing
              break;
            case NovelReadingStatus.hiatusCompleted:
              UserServices.changeHiatusNovelCountOfUser(
                widget.userId ?? Preference.getUserId(),
                tempUserController.userData.totalNovelReadCompleteWithNovelHiatus! - 1,
              );
              break;
            case NovelReadingStatus.completed:
              UserServices.changeCompleteNovelCountOfUser(
                widget.userId ?? Preference.getUserId(),
                tempUserController.userData.totalNovelReadCompleteWithNovelComplete! - 1,
              );
              break;
            default:
              break;
          }
          switch (novelReadingStatus) {
            case NovelReadingStatus.notStarted:
              //do nothing
              break;
            case NovelReadingStatus.reading:
              //do nothing
              break;
            case NovelReadingStatus.hiatusCompleted:
              UserServices.changeHiatusNovelCountOfUser(
                widget.userId ?? Preference.getUserId(),
                tempUserController.userData.totalNovelReadCompleteWithNovelHiatus! + 1,
              );
              break;
            case NovelReadingStatus.completed:
              UserServices.changeCompleteNovelCountOfUser(
                widget.userId ?? Preference.getUserId(),
                tempUserController.userData.totalNovelReadCompleteWithNovelComplete! + 1,
              );
              break;
            default:
              break;
          }
        }
        if (oldNovelData!.readNovelChapterCount != int.parse(readChapterController.text)) {
          final tempUserController = Get.put(UserDataController());
          UserServices.changeTotalChapterReadCountOfUser(
            widget.userId ?? Preference.getUserId(),
            tempUserController.userData.totalChapterReadCount! + (int.parse(readChapterController.text) - (oldNovelData!.readNovelChapterCount ?? 0)),
          );
        }*/

/*switch (novelReadingStatus) {
          case NovelReadingStatus.notStarted:
          case NovelReadingStatus.reading:
            UserServices.changeTotalNovelCountOfUser(
              widget.userId ?? Preference.getUserId(),
              tempUserController.userData.totalStartedNovelCount! + 1,
            );
            break;
          case NovelReadingStatus.hiatusCompleted:
            UserServices.changeTotalNovelCountOfUser(
              widget.userId ?? Preference.getUserId(),
              tempUserController.userData.totalStartedNovelCount! + 1,
            );
            UserServices.changeHiatusNovelCountOfUser(
              widget.userId ?? Preference.getUserId(),
              tempUserController.userData.totalNovelReadCompleteWithNovelHiatus! + 1,
            );
            break;
          case NovelReadingStatus.completed:
            UserServices.changeTotalNovelCountOfUser(
              widget.userId ?? Preference.getUserId(),
              tempUserController.userData.totalStartedNovelCount! + 1,
            );
            UserServices.changeCompleteNovelCountOfUser(
              widget.userId ?? Preference.getUserId(),
              tempUserController.userData.totalNovelReadCompleteWithNovelComplete! + 1,
            );
            break;
          default:
            break;
        }
        UserServices.changeTotalChapterReadCountOfUser(
          widget.userId ?? Preference.getUserId(),
          tempUserController.userData.totalChapterReadCount! + (readChapterController.text.isEmpty ? 0 : int.parse(readChapterController.text)),
        );*/
/*return Navigator(
                    key: drawerNavigatorKey,
                    initialRoute: snapshot.data ?? yourNovelListScreenRoute,
                    onGenerateRoute: (RouteSettings settings) {
                      RoutePageBuilder builder;
                      switch (settings.name) {
                        case yourNovelListScreenRoute:
                          builder = (_, __, ___) => YourNovelListScreen(
                                showAppBar: true,
                                userId: settings.arguments as String,
                              );
                          break;
                        case novelWishListScreenRoute:
                          builder = (_, __, ___) => NovelWishListScreen(
                                showAppBar: true,
                                userId: settings.arguments as String,
                              );
                          break;
                        case novelHiddenListScreenRoute:
                          builder = (_, __, ___) => NovelHiddenListScreen(
                                showAppBar: true,
                                userId: settings.arguments as String,
                              );
                          break;
                        case profileScreenRoute:
                          builder = (_, __, ___) => ProfileScreen(
                                showAppBar: true,
                                userId: settings.arguments as String,
                              );
                          break;
                        case changePasswordScreenRoute:
                          builder = (_, __, ___) => ChangePasswordScreen(
                                showAppBar: true,
                                userId: settings.arguments as String,
                              );
                          break;
                        case changeHiddenPinScreenRoute:
                          builder = (_, __, ___) => ChangeHiddenPinScreen(
                                showAppBar: true,
                                userId: settings.arguments as String,
                              );
                          break;
                        default:
                          builder = (_, __, ___) => YourNovelListScreen(
                                showAppBar: true,
                                userId: settings.arguments as String,
                              );
                          break;
                      }
                      return PageRouteBuilder(
                        pageBuilder: builder,
                        transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                        maintainState: true,
                      );
                    },
                  );*/

/*decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: width > 600 ? bigBackgroundImage.image : smallBackgroundImage.image,
          fit: BoxFit.cover,
        ),
      ),*/

/*//create material for page
  MaterialPage _createPage(Widget child, PageConfiguration pageConfig) {
    return MaterialPage(
      child: child,
      key: ValueKey(pageConfig.key),
      name: pageConfig.path,
      arguments: pageConfig.arguments,
    );
  }

  FadePage _createFadePage(Widget child, PageConfiguration pageConfig) {
    return FadePage(
      child: child,
      key: ValueKey(pageConfig.key),
      name: pageConfig.path,
      arguments: pageConfig.arguments,
    );
  }

  SlideDownPage _createSlidePage(Widget child, PageConfiguration pageConfig) {
    return SlideDownPage(
      child: child,
      key: ValueKey(pageConfig.key),
      name: pageConfig.path,
      arguments: pageConfig.arguments,
    );
  }*/

/*void _addFadePage(Widget child, PageConfiguration pageConfig) {
    pages.add(
      _createFadePage(child, pageConfig),
    );
  }

  void _addFadePageAtIndex(int index, Widget child, PageConfiguration pageConfig) {
    pages.insert(
      index,
      _createFadePage(child, pageConfig),
    );
  }

  void _addPageData(Widget child, PageConfiguration pageConfig) {
    pages.add(
      _createPage(child, pageConfig),
    );
  }

  void _addPageAtIndex(int index, Widget child, PageConfiguration pageConfig) {
    pages.insert(
      index,
      _createPage(child, pageConfig),
    );
  }*/

/*
  void addPageAtIndex(int index, PageConfiguration pageConfig) {
    switch (pageConfig.path) {
      case splashScreenRoute:
        _addPageAtIndex(
          index,
          const SplashScreen(),
          pageConfig,
        );
        break;
      case loginScreenRoute:
        _addPageAtIndex(
          index,
          const LoginScreen(),
          pageConfig,
        );
        break;
      case signUpScreenRoute:
        _addPageAtIndex(
          index,
          const SignUpScreen(),
          pageConfig,
        );
        break;
      case drawerScreenRoute:
        _addPageAtIndex(
          index,
          const DrawerScreen(),
          pageConfig,
        );
        break;
      case createNovelListItemScreenRoute:
        _addPageAtIndex(
          index,
          const CreateNovelListItemScreen(),
          pageConfig,
        );
        break;
      case createNovelWishListItemScreenRoute:
        _addPageAtIndex(
          index,
          const CreateNovelWishListItemScreen(),
          pageConfig,
        );
        break;
      case createNovelHiddenListItemScreenRoute:
        _addPageAtIndex(
          index,
          const CreateNovelHiddenListItemScreen(),
          pageConfig,
        );
        break;
      case forgetPasswordScreenRoute:
        _addPageAtIndex(
          index,
          const ForgetPasswordScreen(),
          pageConfig,
        );
        break;
      default:
        _addPageAtIndex(
          index,
          const SplashScreen(),
          pageConfig,
        );
        break;
    }
  }

  void addFadePageAtIndex(int index, PageConfiguration pageConfig) {
    switch (pageConfig.path) {
      case splashScreenRoute:
        _addFadePageAtIndex(
          index,
          const SplashScreen(),
          pageConfig,
        );
        break;
      case loginScreenRoute:
        _addFadePageAtIndex(
          index,
          const LoginScreen(),
          pageConfig,
        );
        break;
      case signUpScreenRoute:
        _addFadePageAtIndex(
          index,
          const SignUpScreen(),
          pageConfig,
        );
        break;
      case drawerScreenRoute:
        _addFadePageAtIndex(
          index,
          const DrawerScreen(),
          pageConfig,
        );
        break;
      case createNovelListItemScreenRoute:
        _addFadePageAtIndex(
          index,
          const CreateNovelListItemScreen(),
          pageConfig,
        );
        break;
      case createNovelWishListItemScreenRoute:
        _addFadePageAtIndex(
          index,
          const CreateNovelWishListItemScreen(),
          pageConfig,
        );
        break;
      case createNovelHiddenListItemScreenRoute:
        _addFadePageAtIndex(
          index,
          const CreateNovelHiddenListItemScreen(),
          pageConfig,
        );
        break;
      case forgetPasswordScreenRoute:
        _addFadePageAtIndex(
          index,
          const ForgetPasswordScreen(),
          pageConfig,
        );
        break;
      default:
        _addFadePageAtIndex(
          index,
          const SplashScreen(),
          pageConfig,
        );
        break;
    }
  }

  void addPage(PageConfiguration pageConfig) {
    switch (pageConfig.path) {
      case splashScreenRoute:
        _addPageData(
          const SplashScreen(),
          pageConfig,
        );
        break;
      case loginScreenRoute:
        _addPageData(
          const LoginScreen(),
          pageConfig,
        );
        break;
      case signUpScreenRoute:
        _addPageData(
          const SignUpScreen(),
          pageConfig,
        );
        break;
      case drawerScreenRoute:
        _addPageData(
          const DrawerScreen(),
          pageConfig,
        );
        break;
      case createNovelListItemScreenRoute:
        _addPageData(
          const CreateNovelListItemScreen(),
          pageConfig,
        );
        break;
      case createNovelWishListItemScreenRoute:
        _addPageData(
          const CreateNovelWishListItemScreen(),
          pageConfig,
        );
        break;
      case createNovelHiddenListItemScreenRoute:
        _addPageData(
          const CreateNovelHiddenListItemScreen(),
          pageConfig,
        );
        break;
      case forgetPasswordScreenRoute:
        _addPageData(
          const ForgetPasswordScreen(),
          pageConfig,
        );
        break;
      default:
        _addPageData(
          const SplashScreen(),
          pageConfig,
        );
        break;
    }
  }

  void addFadePage(PageConfiguration pageConfig) {
    switch (pageConfig.path) {
      case splashScreenRoute:
        _addFadePage(
          const SplashScreen(),
          pageConfig,
        );
        break;
      case loginScreenRoute:
        _addFadePage(
          const LoginScreen(),
          pageConfig,
        );
        break;
      case signUpScreenRoute:
        _addFadePage(
          const SignUpScreen(),
          pageConfig,
        );
        break;
      case drawerScreenRoute:
        _addFadePage(
          const DrawerScreen(),
          pageConfig,
        );
        break;
      case createNovelListItemScreenRoute:
        _addFadePage(
          const CreateNovelListItemScreen(),
          pageConfig,
        );
        break;
      case createNovelWishListItemScreenRoute:
        _addFadePage(
          const CreateNovelWishListItemScreen(),
          pageConfig,
        );
        break;
      case createNovelHiddenListItemScreenRoute:
        _addFadePage(
          const CreateNovelHiddenListItemScreen(),
          pageConfig,
        );
        break;
      case forgetPasswordScreenRoute:
        _addFadePage(
          const ForgetPasswordScreen(),
          pageConfig,
        );
        break;
      default:
        _addFadePage(
          const SplashScreen(),
          pageConfig,
        );
        break;
    }
  }*/

/*switch (transitionType) {
        case TransitionType.defaultTransition:
          pages.insert(
            index,
            TransitionList.createPage(child, pageConfiguration),
          );
          break;
        case TransitionType.fadeTransition:
          pages.insert(
            index,
            TransitionList.createFadePage(child, pageConfiguration),
          );
          break;
        case TransitionType.slideDownTransition:
          pages.insert(
            index,
            TransitionList.createSlidePage(child, pageConfiguration),
          );
          break;
      }*/

/*switch (transitionType) {
        case TransitionType.defaultTransition:
          pages.add(
            TransitionList.createPage(child, pageConfiguration),
          );
          break;
        case TransitionType.fadeTransition:
          pages.add(
            TransitionList.createFadePage(child, pageConfiguration),
          );
          break;
        case TransitionType.slideDownTransition:
          pages.add(
            TransitionList.createSlidePage(child, pageConfiguration),
          );
          break;
      }*/

/*void addCommonPage({int? index, required PageConfiguration pageConfig, TransitionType transitionType = TransitionType.defaultTransition}) {
    switch (pageConfig.path) {
      case yourNovelListScreenRoute:
        _addCommonPage(
          index: index,
          pageConfiguration: pageConfig,
          transitionType: transitionType,
          child: YourNovelListScreen(
            userId: pageConfig.arguments as String,
          ),
        );
        break;
      case novelWishListScreenRoute:
        _addCommonPage(
          index: index,
          pageConfiguration: pageConfig,
          transitionType: transitionType,
          child: NovelWishListScreen(
            userId: pageConfig.arguments as String,
          ),
        );
        break;
      case novelHiddenListScreenRoute:
        _addCommonPage(
          index: index,
          pageConfiguration: pageConfig,
          transitionType: transitionType,
          child: NovelHiddenListScreen(
            userId: pageConfig.arguments as String,
          ),
        );
        break;
      case profileScreenRoute:
        _addCommonPage(
          index: index,
          pageConfiguration: pageConfig,
          transitionType: transitionType,
          child: ProfileScreen(
            userId: pageConfig.arguments as String,
          ),
        );
        break;
      case changePasswordScreenRoute:
        _addCommonPage(
          index: index,
          pageConfiguration: pageConfig,
          transitionType: transitionType,
          child: ChangePasswordScreen(
            userId: pageConfig.arguments as String,
          ),
        );
        break;
      case changeHiddenPinScreenRoute:
        _addCommonPage(
          index: index,
          pageConfiguration: pageConfig,
          transitionType: transitionType,
          child: ChangeHiddenPinScreen(
            userId: pageConfig.arguments as String,
          ),
        );
        break;
      default:
        _addCommonPage(
          index: index,
          pageConfiguration: pageConfig,
          transitionType: transitionType,
          child: YourNovelListScreen(
            userId: Preference.getUserId(),
          ),
        );
        break;
    }
  }*/

/*void addCommonPage({
    int? index,
    required PageConfiguration pageConfig,
    TransitionType transitionType = TransitionType.defaultTransition,
  }) {
    switch (pageConfig.path) {
      case splashScreenRoute:
        _addCommonPage(
          index: index,
          child: const SplashScreen(),
          pageConfiguration: pageConfig,
          transitionType: transitionType,
        );
        break;
      case loginScreenRoute:
        _addCommonPage(
          index: index,
          pageConfiguration: pageConfig,
          transitionType: transitionType,
          child: const LoginScreen(),
        );
        break;
      case signUpScreenRoute:
        _addCommonPage(
          index: index,
          pageConfiguration: pageConfig,
          transitionType: transitionType,
          child: const SignUpScreen(),
        );
        break;
      case drawerScreenRoute:
        _addCommonPage(
          index: index,
          pageConfiguration: pageConfig,
          transitionType: transitionType,
          child: const DrawerScreen(),
        );
        break;
      case createNovelListItemScreenRoute:
        _addCommonPage(
          index: index,
          pageConfiguration: pageConfig,
          transitionType: transitionType,
          child: const CreateNovelListItemScreen(),
        );
        break;
      case createNovelWishListItemScreenRoute:
        _addCommonPage(
          index: index,
          pageConfiguration: pageConfig,
          transitionType: transitionType,
          child: const CreateNovelWishListItemScreen(),
        );
        break;
      case createNovelHiddenListItemScreenRoute:
        _addCommonPage(
          index: index,
          pageConfiguration: pageConfig,
          transitionType: transitionType,
          child: const CreateNovelHiddenListItemScreen(),
        );
        break;
      case forgetPasswordScreenRoute:
        _addCommonPage(
          index: index,
          pageConfiguration: pageConfig,
          transitionType: transitionType,
          child: const ForgetPasswordScreen(),
        );
        break;
      default:
        _addCommonPage(
          index: index,
          pageConfiguration: pageConfig,
          transitionType: transitionType,
          child: const SplashScreen(),
        );
        break;
    }
  }*/

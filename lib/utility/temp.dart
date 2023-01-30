/*
* Created by Shrikunj Patel on 1/24/2023.
*/

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

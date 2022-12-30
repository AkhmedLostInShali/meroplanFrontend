import 'package:flutter/material.dart';
import 'package:hacaton/ui/widgets/entity_models/auth_model.dart';
import 'package:hacaton/ui/widgets/inherited/notifier_provider.dart';
import 'package:hacaton/ui/widgets/screens/auth/auth_widget.dart';
import 'package:hacaton/ui/widgets/screens/main_screen/main_screen_widget.dart';
import 'package:provider/provider.dart';

abstract class MainNavigationRouteNames {
  static const String auth = 'auth';
  static const String mainScreen = '/';
  static const String myProfile = '/my_profile';
  static const String friends = '/friends';
  static const String userDetails = '/user_details';
}

class MainNavigation {
  String initialRoute(bool isAuth) => isAuth
      ? MainNavigationRouteNames.mainScreen
      : MainNavigationRouteNames.auth;

  final routes = <String, Widget Function(BuildContext)>{
    'auth': (context) => ChangeNotifierProvider(
        create: (_) => AuthViewModel(), child: const AuthWidget()),
    '/': (context) => const MainScreenWidget(),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.userDetails:
        final arguments = settings.arguments;
        // if (arguments is int) {
        //   return MaterialPageRoute(
        //       builder: (context) => NotifierProvider(
        //           create: () => UserDetailsWidgetModel(arguments),
        //           isManagingModel: true,
        //           child: UserDetailsWidget(
        //             userID: arguments,
        //           )));
        // }
        return MaterialPageRoute(
            builder: (context) => const Center(
                  child: Text('ERROR'),
                ));
      default:
        return MaterialPageRoute(
            builder: (context) => const Center(
                  child: Text('ERROR'),
                ));
    }
  }
}

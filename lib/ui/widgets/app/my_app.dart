import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hacaton/ui/navigation/main_navigation.dart';
import 'package:hacaton/ui/theme/my_colors.dart';
import 'package:hacaton/ui/widgets/app/my_app_data_model.dart';

class MyApp extends StatelessWidget {
  final MyAppModel model;
  static final MainNavigation mainNavigation = MainNavigation();
  const MyApp({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialApp app = MaterialApp(
      theme: ThemeData(
        backgroundColor: MyColors.lightGray,
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 32,
                color: MyColors.lavender),
            color: Colors.white,
            elevation: 8),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: MyColors.lightGray,),
      routes: mainNavigation.routes,
      initialRoute: mainNavigation.initialRoute(model.isAuth),
      onGenerateRoute: mainNavigation.onGenerateRoute,
    );
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark
    ));
    return app;
  }
}

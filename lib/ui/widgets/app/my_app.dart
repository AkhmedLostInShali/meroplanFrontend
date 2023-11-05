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
        colorScheme: const ColorScheme.dark(background: MyColors.black),
        scaffoldBackgroundColor: MyColors.black
      ),
      routes: mainNavigation.routes,
      initialRoute: mainNavigation.initialRoute(model.isAuth),
      onGenerateRoute: mainNavigation.onGenerateRoute,
    );
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: MyColors.black,
        statusBarIconBrightness: Brightness.dark
    ));
    return app;
  }
}

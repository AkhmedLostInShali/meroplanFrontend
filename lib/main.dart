import 'package:flutter/material.dart';
import 'package:hacaton/ui/widgets/app/my_app.dart';
import 'package:hacaton/ui/widgets/app/my_app_data_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final model = MyAppModel();
  await model.checkAuth();
  final app = MyApp(model: model);
  runApp(app);
}

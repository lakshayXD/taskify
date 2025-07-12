import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list/theme/app_theme.dart';
import 'package:todo_list/utils/globals.dart';
import 'package:todo_list/utils/route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      onGenerateRoute: RouteGenerator.generateRoute,
      scaffoldMessengerKey: AppGlobals.scaffoldMessengerKey,
      initialRoute: RouteGenerator.initialRoute,
    );
  }
}
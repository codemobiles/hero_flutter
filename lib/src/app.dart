import 'package:flutter/material.dart';
import 'package:hero_flutter/src/configs/routes/app_route.dart';
import 'package:hero_flutter/src/pages/login/login_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: AppRoute().getAll,
      home: LoginPage(),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:hero_flutter/src/configs/routes/app_route.dart';
import 'package:hero_flutter/src/constants/app_setting.dart';
import 'package:hero_flutter/src/pages/home/home_page.dart';
import 'package:hero_flutter/src/pages/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: AppRoute().getAll,
      home: _buildHomePage(),
    );
  }

   FutureBuilder<SharedPreferences> _buildHomePage() => FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            color: Colors.white,
          );
        }

        final token = snapshot.data?.getString(AppSetting.token) ?? "";
        if (token.isEmpty) {
          return LoginPage();
        }
        return HomePage();
      },
    );
}

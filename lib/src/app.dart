import 'package:flutter/material.dart';
import 'package:hero_flutter/src/configs/routes/app_route.dart';
import 'package:hero_flutter/src/constants/app_setting.dart';
import 'package:hero_flutter/src/pages/home/home_page.dart';
import 'package:hero_flutter/src/pages/login/login_page.dart';
import 'package:hero_flutter/src/utils/services/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: AppRoute().getAll,
      home: _buildHomePage(),
    );
  }

   FutureBuilder<String> _buildHomePage() => FutureBuilder<String>(
      future: LocalStorageService().getToken(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            color: Colors.white,
          );
        }

        final token = snapshot.data;
        if (token!.isEmpty) {
          return LoginPage();
        }
        return HomePage();
      },
    );
}

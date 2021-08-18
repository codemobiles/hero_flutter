
import 'package:flutter/cupertino.dart';
import 'package:hero_flutter/src/pages/pages.dart';

class AppRoute {
  static const home = 'home';
  static const login = 'login';
  static const management = 'management';

  final _route = <String, WidgetBuilder> {
    home: (context) => HomePage(),
    login: (context) => LoginPage(),
    management: (context) => ManagementPage(),
  };

  get getAll => _route;
}

import 'package:flutter/cupertino.dart';
import 'package:hero_flutter/src/pages/pages.dart';

class AppRoute {
  static const home = 'home';
  static const login = 'login';

  final _route = <String, WidgetBuilder> {
    home: (context) => HomePage(),
    login: (context) => LoginPage(),
  };

  get getAll => _route;
}
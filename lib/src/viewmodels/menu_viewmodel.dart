import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hero_flutter/src/configs/routes/app_route.dart';

class Menu {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Function(BuildContext context) navigator;
  final String? notification;

  const Menu(
      this.title, {
        required this.navigator,
        required this.icon,
        this.iconColor = Colors.grey,
        this.notification,
      });
}

class MenuViewModel {
  final _menus = <Menu>[
    Menu(
      'Profile',
      icon: FontAwesomeIcons.user,
      iconColor: Colors.deepOrange,
      navigator: (context) {
        //todo
      },
    ),
    Menu(
      'Dashboard',
      icon: FontAwesomeIcons.chartPie,
      iconColor: Colors.green,
      navigator: (context) {
        //todo
      },
    ),
    Menu(
      'Map',
      icon: FontAwesomeIcons.map,
      iconColor: Colors.blue,
      navigator: (context) {
        // Navigator.pushNamed(context, AppRoute.map);
      },
    ),
    Menu(
      'Settings',
      icon: FontAwesomeIcons.cogs,
      iconColor: Colors.blueGrey,
      navigator: (context) {
        //todo
      },
    ),
  ];

  MenuViewModel();

  List<Menu> get items => _menus;

  set setInBox(String count) {
    final inBox = Menu(
      'InBox',
      icon: FontAwesomeIcons.inbox,
      iconColor: Colors.amber,
      navigator: (context) {
        //todo
      },
      notification: count,
    );
    _menus.insert(2, inBox);
  }
}
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hero_flutter/src/configs/routes/app_route.dart';
import 'package:hero_flutter/src/constants/app_setting.dart';
import 'package:hero_flutter/src/viewmodels/menu_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('appbarTitle'),
      ),
      body: Center(
        child: Container(
          child: Text('You tapped the FAB times'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment Counter',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildProfile(),
          ..._buildMainMenu(context),
          Spacer(),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.signOutAlt),
            title: Text('Log out'),
            onTap: () => _logout(context),
          )
        ],
      ),
    );
  }

  void _logout(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('title'),
          content: Text('dialogBody'),
          actions: <Widget>[
            TextButton(
              child: Text('cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
            TextButton(
              child: Text(
                'Log out',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onPressed: () async {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                final pref = await SharedPreferences.getInstance();
                pref.remove(AppSetting.token);
                //pref.clear();
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoute.login, (route) => false);
              },
            ),
          ],
        );
      },
    );
  }

  UserAccountsDrawerHeader _buildProfile() => UserAccountsDrawerHeader(
        currentAccountPicture: Container(
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://cdn-images-1.medium.com/max/280/1*X5PBTDQQ2Csztg3a6wofIQ@2x.png'),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
        accountName: Text('iBlurBlur'),
        accountEmail: Text('tanakorn.ngam@gmail.com'),
      );

  List<ListTile> _buildMainMenu(BuildContext context) {
    final menuViewModel = MenuViewModel()..setInBox = '99';
    return menuViewModel.items
      .map((item) => ListTile(
            title: Text(item.title),
            leading: _buildBadge(
              item.notification ?? '',
              icon: item.icon,
              iconColor: item.iconColor,
            ),
          ))
      .toList();
  }

  Badge _buildBadge(
    String notification, {
    required IconData icon,
    required Color iconColor,
  }) {
    final isMaxNotification = notification.length >= 3;
    return Badge(
      toAnimate: false,
      shape: isMaxNotification ? BadgeShape.square : BadgeShape.circle,
      borderRadius:
          isMaxNotification ? BorderRadius.circular(8) : BorderRadius.zero,
      showBadge: notification.isNotEmpty,
      badgeContent: Text(
        notification.length >= 4 ? '999+' : notification,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
      badgeColor: Colors.red,
      child: FaIcon(
        icon,
        color: iconColor,
      ),
    );
  }
}

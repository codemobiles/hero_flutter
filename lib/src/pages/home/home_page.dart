import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hero_flutter/src/configs/routes/app_route.dart';
import 'package:hero_flutter/src/constants/app_setting.dart';
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
                Navigator.pushNamedAndRemoveUntil(context, AppRoute.login, (route) => false);
              },
            ),
          ],
        );
      },
    );
  }
}

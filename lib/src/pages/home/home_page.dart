import 'dart:async';

import 'package:badges/badges.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hero_flutter/src/configs/routes/app_route.dart';
import 'package:hero_flutter/src/constants/app_setting.dart';
import 'package:hero_flutter/src/models/product.dart';
import 'package:hero_flutter/src/pages/home/widgets/product_item.dart';
import 'package:hero_flutter/src/utils/services/network_service.dart';
import 'package:hero_flutter/src/viewmodels/menu_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _refreshController = StreamController<void>();

  @override
  void dispose() {
    _refreshController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[400],
      drawer: CustomDrawer(),
      appBar: AppBar(
        centerTitle: false,
        title: Text('Stock Workshop'),
      ),
      body: StreamBuilder<void>(
        stream: _refreshController.stream,
        builder: (context, snapshot) {
          return FutureBuilder<List<Product>>(
            future: NetworkService().getProduct(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }

              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              final product = snapshot.data;
              if (product!.isEmpty) {
                return Text('Empty');
              }
              return _buildProductGrid(product);
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigatorManagementPage(),
        tooltip: 'Increment Counter',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  RefreshIndicator _buildProductGrid(List<Product> product) => RefreshIndicator(
        onRefresh: () async => _refreshController.sink.add(null),
        child: GridView.builder(
          padding: EdgeInsets.all(2),
          itemCount: product.length,
          itemBuilder: (context, index) => ProductItem(
            product[index],
            onTap: () => _navigatorManagementPage(product[index]),
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            childAspectRatio: 0.8,
          ),
        ),
      );

  void _navigatorManagementPage([Product? product]) {
    Navigator.pushNamed(context, AppRoute.management, arguments: product).then(
      (value) => setState(() {}),
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
          _buildLogoutButton(),
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
              onTap: () => item.navigator(context),
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

  Builder _buildLogoutButton() => Builder(
    builder: (context) => SafeArea(
      child: ListTile(
        leading: FaIcon(FontAwesomeIcons.signOutAlt),
        title: Text('Log out'),
        onTap: () => _logout(context),
      ),
    ),
  );
}

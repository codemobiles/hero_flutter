import 'package:flutter/material.dart';
import 'package:hero_flutter/src/configs/routes/app_route.dart';
import 'package:hero_flutter/src/constants/app_setting.dart';
import 'package:hero_flutter/src/pages/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Form extends StatefulWidget {
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<Form> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      _usernameController.text = value.getString(AppSetting.username) ?? "";
    });
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Card(
          margin: const EdgeInsets.only(bottom: 24, left: 22, right: 22),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 22,
              left: 22,
              right: 22,
              bottom: 42,
            ),
            child: Column(
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: 'codemobiles@gmail.com',
                    labelText: 'email',
                    icon: Icon(Icons.email),
                  ),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'password',
                    icon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 220,
          child: ElevatedButton(
            onPressed: _login,
            child: Text('LOGIN'),
          ),
        ),
      ],
    );
  }

  void _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    if(username == 'admin' && password == 'password'){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppSetting.token, 'TExkgk0494oksrkf');
      await prefs.setString(AppSetting.username, username);

      // method 1
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage(),),);

      // method 2
      Navigator.pushReplacementNamed(context, AppRoute.home);
    }
  }
}

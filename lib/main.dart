import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 120,
            ),
            SizedBox(height: 22),
            Stack(
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
                          decoration: InputDecoration(
                            hintText: 'codemobiles@gmail.com',
                            labelText: 'email',
                            icon: Icon(Icons.email),
                          ),
                        ),
                        TextField(
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
                    onPressed: () {},
                    child: Text('LOGIN'),
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'forgot password?',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 12),
            SSOButton(),
            SizedBox(height: 12),
            TextButton(
              onPressed: () {},
              child: Text(
                'register?',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SSOButton extends StatelessWidget {
  const SSOButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: SSOViewModel().items.map((item) => _buildButton(item)).toList(),
      ),
    );
  }

  FloatingActionButton _buildButton(SSO item) => FloatingActionButton(
      onPressed: item.onPress,
      backgroundColor: item.backgroundColor,
      child: Icon(
        item.icon,
        color: Colors.white,
      ),
    );
}

class SSO {
  final IconData icon;
  final Color? backgroundColor;
  final VoidCallback? onPress;

  const SSO(
    this.icon, {
    this.backgroundColor = Colors.white,
    this.onPress,
  });
}

class SSOViewModel {
  const SSOViewModel();

  List<SSO> get items => <SSO>[
        SSO(
          FontAwesomeIcons.apple,
          backgroundColor: Color(0xFF323232),
          onPress: () {
            //todo
          },
        ),
        SSO(
          FontAwesomeIcons.google,
          backgroundColor: Color(0xFFd7483b),
          onPress: () {
            //todo
          },
        ),
        SSO(
          FontAwesomeIcons.facebookF,
          backgroundColor: Color(0xFF4063ae),
          onPress: () {
            //todo
          },
        ),
        SSO(
          FontAwesomeIcons.line,
          backgroundColor: Color(0xFF21b54d),
          onPress: () {
            //todo
          },
        ),
      ];
}

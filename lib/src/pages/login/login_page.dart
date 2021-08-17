import 'package:flutter/material.dart';
import 'package:hero_flutter/src/pages/login/widgets/sso_button.dart';
import 'package:hero_flutter/src/pages/login/widgets/form.dart' as login;

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
            login.Form(),
            _buildTextButton(
              'forgot password?',
              onPressed: () {},
            ),
            SizedBox(height: 12),
            SSOButton(),
            SizedBox(height: 12),
            _buildTextButton(
              'register?',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  TextButton _buildTextButton(String text, {VoidCallback? onPressed}) =>
      TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
}

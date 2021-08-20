import 'package:flutter/material.dart';
import 'package:hero_flutter/src/pages/login/widgets/background_theme.dart';
import 'package:hero_flutter/src/pages/login/widgets/sso_button.dart';
import 'package:hero_flutter/src/pages/login/widgets/form.dart' as login;

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: BackgroundTheme.gradient,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                ),
                Image.asset(
                  'assets/images/logo.png',
                  height: 120,
                ),
                SizedBox(height: 32),
                login.Form(),
                SizedBox(height: 22),
                _buildTextButton(
                  'forgot password?',
                  onPressed: () {},
                ),
                SizedBox(height: 32),
                SSOButton(),
                SizedBox(height: 32),
                _buildTextButton(
                  'register?',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
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

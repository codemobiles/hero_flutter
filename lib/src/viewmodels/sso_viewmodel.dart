import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
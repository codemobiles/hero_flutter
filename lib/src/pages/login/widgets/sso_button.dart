import 'package:flutter/material.dart';
import 'package:hero_flutter/src/viewmodels/sso_viewmodel.dart';

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
    heroTag: item.icon.toString(),
    onPressed: item.onPress,
    backgroundColor: item.backgroundColor,
    child: Icon(
      item.icon,
      color: Colors.white,
    ),
  );
}

import 'package:flutter/material.dart';

class Form extends StatelessWidget {
  const Form({
    Key? key,
  }) : super(key: key);

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
    );
  }
}


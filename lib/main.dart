import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Demo2(),
    );
  }
}

class Demo1 extends StatelessWidget {
  const Demo1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("stateless");
  }
}

class Demo2 extends StatefulWidget {
  const Demo2({Key? key}) : super(key: key);

  @override
  _Demo2State createState() => _Demo2State();
}

class _Demo2State extends State<Demo2> {
  var text = "yai";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(text),
        FloatingActionButton(
          onPressed: () {
            setState(() {
              text = "codemobiles";
            });
          },
        ),
      ],
    );
  }
}

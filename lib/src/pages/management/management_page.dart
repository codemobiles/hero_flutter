import 'package:flutter/material.dart';

class ManagementPage extends StatelessWidget {
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Management'),
      ),
      body: Form(
        key: _form,
        child: Column(
          children: [
            TextFormField(
              onSaved: (text){
                print(text);
              },
            ),
            TextFormField(
              onSaved: (text){
                print(text);
              },
            ),
            TextButton(
              onPressed: () {
                _form.currentState?.save();
              },
              child: Text('submit'),
            ),
          ],
        ),
      ),
    );
  }
}

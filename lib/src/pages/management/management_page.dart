import 'package:flutter/material.dart';
import 'package:hero_flutter/src/models/product.dart';

class ManagementPage extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  var _product = Product();

  @override
  Widget build(BuildContext context) {
    final Object? arguments = ModalRoute.of(context)?.settings.arguments;
    if(arguments !=null && arguments is Product){
      _product = arguments;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Management'),
      ),
      body: Form(
        key: _form,
        child: Column(
          children: [
            TextFormField(
              initialValue: _product.name,
              onSaved: (text){
                print(text);
              },
            ),
            TextFormField(
              initialValue: _product.price.toString(),
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

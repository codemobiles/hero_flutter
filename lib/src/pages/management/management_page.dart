import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hero_flutter/src/models/product.dart';
import 'package:hero_flutter/src/pages/management/widgets/product_form.dart';
import 'package:hero_flutter/src/utils/services/network_service.dart';

class ManagementPage extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  var _product = Product();

  @override
  Widget build(BuildContext context) {
    final Object? arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is Product) {
      _product = arguments;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Management'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
            onPressed: _submitForm,
            child: Text('submit'),
          ),
        ],
      ),
      body: ProductForm(
        _product,
        callBackSetImage: _callBackSetImage,
        formKey: _form,
      ),
    );
  }

  void _callBackSetImage(File? imageFIle) {
    //todo
  }

  Future<void> _submitForm() async {
    _form.currentState?.save();
    final result = await NetworkService().addProduct(_product);
    print(result);
  }
}

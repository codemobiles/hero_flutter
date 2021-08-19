import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hero_flutter/src/models/product.dart';
import 'package:hero_flutter/src/pages/management/widgets/product_form.dart';
import 'package:hero_flutter/src/utils/services/network_service.dart';
import 'package:hero_flutter/src/widgets/custom_flushbar.dart';

class ManagementPage extends StatefulWidget {
  @override
  _ManagementPageState createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  final _form = GlobalKey<FormState>();
  var _product = Product();
  var _editMode = false;

  @override
  Widget build(BuildContext context) {
    final Object? arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is Product) {
      _product = arguments;
      _editMode = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Management'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
            onPressed: () => _submitForm(context),
            child: Text('submit'),
          ),
        ],
      ),
      body: ProductForm(
        _product,
        callBackSetImage: _callBackSetImage,
        formKey: _form,
        deleteProduct: _editMode ? _deleteProduct : null,
      ),
    );
  }

  void _deleteProduct(){
    NetworkService().deleteProduct(_product.id!).then((value) {
      Navigator.pop(context);
      CustomFlushbar.showSuccess(context, message: value);
    }).catchError( (exception) {
      CustomFlushbar.showError(context, message: 'Delete fail');
    });
  }

  void _callBackSetImage(File? imageFIle) {
    //todo
  }

  Future<void> _submitForm(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    _form.currentState?.save();
    try {
      CustomFlushbar.showLoading(context);
      String result;
      if (_editMode) {
        result = await NetworkService().editProduct(_product);
      } else {
        result = await NetworkService().addProduct(_product);
      }
      CustomFlushbar.close(context);
      Navigator.pop(context);
      CustomFlushbar.showSuccess(context, message: result);
    } catch (exception) {
      CustomFlushbar.showError(context, message: 'network fail');
    }
  }
}

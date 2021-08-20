import 'dart:io';

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
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    final Object? arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is Product) {
      _product = arguments;
      _editMode = true;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ProductForm(
            _product,
            callBackSetImage: _callBackSetImage,
            formKey: _form,
            deleteProduct: _editMode ? _deleteProduct : null,
          ),
        ),
      ),
    );
  }

  void _deleteProduct() {
    NetworkService().deleteProduct(_product.id!).then((value) {
      Navigator.pop(context);
      CustomFlushbar.showSuccess(context, message: value);
    }).catchError((exception) {
      CustomFlushbar.showError(context, message: 'Delete fail');
    });
  }

  void _callBackSetImage(File? imageFile) {
    _imageFile = imageFile;
  }

  Future<void> _submitForm() async {
    FocusScope.of(context).requestFocus(FocusNode());
    _form.currentState?.save();
    try {
      CustomFlushbar.showLoading(context);
      String result;
      if (_editMode) {
        result =
            await NetworkService().editProduct(_product, imageFile: _imageFile);
      } else {
        result =
            await NetworkService().addProduct(_product, imageFile: _imageFile);
      }
      CustomFlushbar.close(context);
      Navigator.pop(context);
      CustomFlushbar.showSuccess(context, message: result);
    } catch (exception) {
      CustomFlushbar.showError(context, message: 'network fail');
    }
  }
}

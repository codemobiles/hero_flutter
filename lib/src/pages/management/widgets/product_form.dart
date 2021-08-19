import 'package:flutter/material.dart';
import 'package:hero_flutter/src/models/product.dart';
import 'package:hero_flutter/src/pages/management/widgets/product_image.dart';

class ProductForm extends StatelessWidget {
  final _spacing = 8.0;
  final Product product;
  final Function callBackSetImage;
  final Function? deleteProduct;
  final GlobalKey<FormState> formKey;

  const ProductForm(
    this.product, {
    required this.callBackSetImage,
    required this.formKey,
    this.deleteProduct,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          _buildNameInput(),
          SizedBox(height: _spacing),
          Row(
            children: <Widget>[
              Flexible(
                child: _buildPriceInput(),
              ),
              SizedBox(width: _spacing),
              Flexible(
                child: _buildStockInput(),
              ),
            ],
          ),
          ProductImage(
            callBackSetImage,
            image: product.image,
          ),
          SizedBox(height: 28),
          if (deleteProduct != null) _buildDeleteButton(context),
          SizedBox(height: 80),
        ],
      ),
    );
  }

  InputDecoration _inputStyle(String label) => InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black12,
          ),
        ),
        labelText: label,
      );

  TextFormField _buildNameInput() => TextFormField(
        initialValue: product.name,
        decoration: _inputStyle('name'),
        onSaved: (String? value) {
          product.name = value;
        },
      );

  TextFormField _buildPriceInput() => TextFormField(
        initialValue: product.price?.toString(),
        decoration: _inputStyle('price'),
        keyboardType: TextInputType.number,
        onSaved: (String? value) {
          var price = 0;
          if (value != null && value.isNotEmpty) {
            price = int.parse(value);
          }
          product.price = price;
        },
      );

  TextFormField _buildStockInput() => TextFormField(
        initialValue: product.stock?.toString(),
        decoration: _inputStyle('stock'),
        keyboardType: TextInputType.number,
        onSaved: (String? value) {
          var stock = 0;
          if (value != null && value.isNotEmpty) {
            stock = int.parse(value);
          }
          product.stock = stock;
        },
      );

  FloatingActionButton _buildDeleteButton(BuildContext context) =>
      FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () => _delete(context),
        child: Icon(Icons.delete_outlined),
      );

  void _delete(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Delete Product'),
          content: Text('Are you sure you want to delete?'),
          actions: <Widget>[
            TextButton(
              child: Text('cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: Text(
                'ok',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                deleteProduct!();
              },
            ),
          ],
        );
      },
    );
  }
}

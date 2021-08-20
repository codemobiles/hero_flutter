import 'package:flutter/material.dart';
import 'package:hero_flutter/src/constants/network_api.dart';
import 'package:hero_flutter/src/models/product.dart';
import 'package:hero_flutter/src/utils/helpers/format.dart';
import 'package:hero_flutter/src/widgets/image_not_found.dart';
import 'package:hero_flutter/src/constants/network_api.dart';
import 'package:hero_flutter/src/widgets/image_not_found.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductItem(this.product, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              _buildImage(constraints.maxHeight),
              _buildInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Stack _buildImage(double maxHeight) {
    final height = maxHeight * 0.65;
    final image = product.image;
    final stock = product.stock ?? 0;

    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: height,
          child: image != null && image.isNotEmpty
              ? Image.network(
            '${NetworkAPI.imageURL}/$image',
            width: double.infinity,
            fit: BoxFit.cover,
          )
              : ImageNotFound(),
        ),
        if (stock <= 0) _buildOutOfStock(),
      ],
    );
  }

  Expanded _buildInfo() => Expanded(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name ?? "-",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '฿${formatCurrency.format(product.price)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
               '${formatNumber.format(product.stock)} pieces',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrangeAccent,
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );

  Positioned _buildOutOfStock() => Positioned(
    top: 2,
    right: 2,
    child: Card(
      color: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          'out of stock',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    ),
  );
}
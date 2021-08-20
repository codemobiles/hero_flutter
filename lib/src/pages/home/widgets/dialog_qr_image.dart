import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DialogQRImage extends StatelessWidget {
  final String data;
  final String image;

  const DialogQRImage(this.data, {this.image = ''});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildQRImage(),
            Container(
              margin: EdgeInsets.only(top: 12),
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('close'),
              ),
            )
          ],
        ),
      ),
    );
  }

  QrImage _buildQRImage() => QrImage(
    data: data,
    size: 220.0,
    embeddedImage: image.isEmpty ? null : AssetImage(image),
    embeddedImageStyle: QrEmbeddedImageStyle(
      size: Size(50, 50),
      // color: Colors.red,
    ),
    embeddedImageEmitsError: true,
    errorStateBuilder: (cxt, err) => Center(
      child: Text("Uh oh! Something went wrong..."),
    ),
  );
}
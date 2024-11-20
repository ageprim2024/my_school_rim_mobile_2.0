import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

showQRModelSheet(BuildContext context, String barCodeScannerRes) {
  if (barCodeScannerRes.isNotEmpty) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: BarcodeWidget(
            data: barCodeScannerRes,
            barcode: Barcode.qrCode(),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gestion_maintenance_mobile/components/widgets/scanned_item.dart';
import 'package:gestion_maintenance_mobile/data/barcode.dart';
import 'package:gestion_maintenance_mobile/localisation/app_localisations.dart';

class ScannedItemsScreen extends StatefulWidget {
  final Record record;
  const ScannedItemsScreen({super.key, required this.record});

  @override
  State<ScannedItemsScreen> createState() => _ScannedItemsScreenState();
}

class _ScannedItemsScreenState extends State<ScannedItemsScreen> {
  @override
  Widget build(BuildContext context) {
    List<int> barcodeKeys = widget.record.barcodes.keys.toList();

    if (barcodeKeys.isEmpty) {
      return Scaffold(
        body: Center(child: Text(Localisations.of(context)!.noItemsScanned)),
      );
    }
    return Scaffold(
      body: ListView.builder(
          itemBuilder: (context, index) {
            int barcode = barcodeKeys[index];
            return ScannedItem(
              index,
              barcode: barcode,
              locationId: widget.record.id,
            );
          },
          itemCount: widget.record.barcodes.length),
    );
  }
}

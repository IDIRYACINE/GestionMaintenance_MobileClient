import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestion_maintenance_mobile/blocs/records/records_block.dart';
import 'package:gestion_maintenance_mobile/blocs/records/records_state.dart';
import 'package:gestion_maintenance_mobile/components/widgets/scanned_item.dart';
import 'package:gestion_maintenance_mobile/core/barcodesCenter/barcodes_center.dart';
import 'package:gestion_maintenance_mobile/core/extensions/toaster.dart';
import 'package:gestion_maintenance_mobile/localisation/app_localisations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, this.testMode = false});

  final bool testMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Localisations.of(context)!.title),
      ),
      body: BlocBuilder<RecordsBloc, RecordState>(
        builder: (context, state) {
          final locationKeys = state.records.keys.toList();

          return ListView.builder(
            itemCount: state.records.length,
            itemBuilder: (context, index) {
              return ScannedLocation(id: locationKeys[index]);
            },
          );
        },
      ),
      floatingActionButton: testMode ? const _MimickScanButton() : null,
    );
  }
}

class _MimickScanButton extends StatelessWidget {
  const _MimickScanButton();

  @override
  Widget build(BuildContext context) {

    return FloatingActionButton(
      onPressed: () {
        ToasterExtension.instance().setBuildContext(context);

        BarcodeCenter.instance().emitBarcode("91080687");
      },
      child: const Icon(Icons.add),
    );
  }
}

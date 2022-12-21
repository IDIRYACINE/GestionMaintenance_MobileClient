import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestion_maintenance_mobile/blocs/records/records_block.dart';
import 'package:gestion_maintenance_mobile/blocs/records/records_state.dart';
import 'package:gestion_maintenance_mobile/data/barcode.dart';
import 'package:gestion_maintenance_mobile/localisation/app_localisations.dart';
import 'package:gestion_maintenance_mobile/ui/home/scanned_items.dart';

enum ScannedItemState {
  pending,
  validated,
  rejected,
}

class ScannedItem extends StatefulWidget {
  final int id;
  final int barcode;
  final int locationId;

  const ScannedItem(this.id,
      {super.key, required this.barcode, required this.locationId});

  @override
  State<ScannedItem> createState() => _ScannedItemState();
}

class _ScannedItemState extends State<ScannedItem> {
  ScannedItemState state = ScannedItemState.pending;

  @override
  Widget build(BuildContext context) {
    
    return Card(
      child: ListTile(
        title: BlocBuilder<RecordsBloc, RecordState>(
            buildWhen: (previous, current) => 
                previous.records[widget.locationId]!.barcodes[widget.barcode]!
                    .state !=
                current
                    .records[widget.locationId]!.barcodes[widget.barcode]!.state,
            builder: (context, state) {
              Barcode item =
                  state.records[widget.locationId]!.barcodes[widget.barcode]!;
              return Text(item.name ?? Localisations.of(context)!.loading);
            }),
        subtitle: Text('${widget.barcode}'),
      ),
    );
  }
}

class ScannedLocation extends StatefulWidget {
  final int id;

  const ScannedLocation({
    super.key,
    required this.id,
  });

  @override
  State<ScannedLocation> createState() => _ScannedLocationState();
}

class _ScannedLocationState extends State<ScannedLocation> {
  String? name;
  int itemCount = 0;

  void displayScannedItemsList(Record record) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScannedItemsScreen(record: record),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordsBloc, RecordState>(builder: (context, state) {
       

      Record record = state.records[widget.id]!;
      return InkWell(
        onTap: () => displayScannedItemsList(state.records[widget.id]!),
        child: Card(
          child: ListTile(
            title: Text(record.name ?? Localisations.of(context)!.loading),
            subtitle: Text(
                '${Localisations.of(context)!.itemsCount} : ${record.count}'),
          ),
        ),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestion_maintenance_mobile/blocs/records/records_block.dart';
import 'package:gestion_maintenance_mobile/blocs/records/records_state.dart';
import 'package:gestion_maintenance_mobile/data/barcode.dart';
import 'package:gestion_maintenance_mobile/localisation/app_localisations.dart';

enum ScannedItemState {
  pending,
  validated,
  rejected,
}

class ScannedItem extends StatefulWidget {
  final int id;
  final int barcode;
  final int locationId;
  final int itemCount;

  const ScannedItem(this.id,
      {super.key,
      required this.itemCount,
      required this.barcode,
      required this.locationId});

  @override
  State<ScannedItem> createState() => _ScannedItemState();
}

class _ScannedItemState extends State<ScannedItem> {
  ScannedItemState state = ScannedItemState.pending;
  int itemCount = 1;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: BlocBuilder<RecordsBloc, RecordState>(
          buildWhen: (previous, current) =>
              previous
                  .records[widget.locationId].barcodes[widget.barcode]!.state !=
              current
                  .records[widget.locationId].barcodes[widget.barcode]!.state,
          builder: (context, state) {
            Barcode item =
                state.records[widget.locationId].barcodes[widget.barcode]!;
            return Text(item.name ?? Localisations.of(context)!.loading);
          }),
      subtitle: Text('${widget.barcode}'),
    );
  }
}

class ScannedLocation extends StatefulWidget {
  final int id;
 

  const ScannedLocation(
      {super.key,
      required this.id,
     });

  @override
  State<ScannedLocation> createState() => _ScannedLocationState();
}

class _ScannedLocationState extends State<ScannedLocation> {
  String? name;
  int itemCount = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordsBloc, RecordState>(builder: (context, state) {
      Record record = state.records[widget.id];
      return ListTile(
        title: Text(record.name ?? Localisations.of(context)!.loading),
        subtitle: Text(
            '${Localisations.of(context)!.itemsCount} : ${record.count}'),
      );
    });
  }
}

